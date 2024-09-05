require 'rails_helper'

RSpec.describe Video, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    context "when valid all" do
      let(:video) { FactoryBot.build :video }

      it "should return true" do
        expect(video.valid?).to be_truthy
      end
    end

    context "when instance invalid" do
      context "validate url" do
        context "when email nil" do
          let(:video) { FactoryBot.build :video, url: nil }

          it "should return false" do
            expect(video.valid?).to be_falsy
            expect(video.errors.details[:url].first.has_value?(:blank)).to be_truthy
          end
        end

        context "when url blank" do
          let(:video) { FactoryBot.build :video, url: '' }

          it "should return false" do
            expect(video.valid?).to be_falsy
            expect(video.errors.details[:url].first.has_value?(:blank)).to be_truthy
          end
        end
      end
    end
  end


  describe "callbacks" do
    context "before_create callback" do
      let(:user) { create(:user) }

      context "when video info is successfully extracted" do
        let(:video_info) do
          {
            title: "Rick Astley - Never Gonna Give You Up (Official Music Video)",
            description: "The official video for “Never Gonna Give You Up” by Rick Astley.",
            embed_url: "https://www.youtube.com/embed/dQw4w9WgXcQ"
          }
        end

        before do
          allow_any_instance_of(ExtractVideoInfoService).to receive(:execute).and_return(video_info)
        end

        it "should assign title, description, and embed_url before creation" do
          video = build(:video, user: user, url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")

          expect(video.save).to be_truthy
          expect(video.title).to eq(video_info[:title])
          expect(video.description).to eq(video_info[:description])
          expect(video.embed_url).to eq(video_info[:embed_url])
        end
      end

      context "when video info extraction fails" do
        before do
          allow_any_instance_of(ExtractVideoInfoService).to receive(:execute).and_return(nil)
        end

        it "should add an error and abort creation" do
          video = build(:video, user: user, url: "invalid_url")

          expect(video.save).to be_falsy
          expect(video.errors[:base]).to include("Video not found or unavailable.")
        end
      end

      context "when url is blank" do
        it "should not call the service and abort the creation" do
          video = build(:video, user: user, url: "")

          expect(ExtractVideoInfoService).not_to receive(:new)
          expect(video.save).to be_falsy
          expect(video.errors[:url]).to include("can't be blank")
        end
      end
    end

    context 'after_create callback' do
      let(:user) { create(:user, username: "test_user") }
      let(:video) { build(:video, user: user, title: "Rick Astley - Never Gonna Give You Up (Official Music Video)") }

      it 'should calls BroadcastNotificationService with correct parameters' do
        expected_payload = {
          type: "new_video",
          message: "New video has been shared",
          sender: user.username,
          title: video.title
        }

        expect_any_instance_of(BroadcastNotificationService).to receive(:execute)
        expect(BroadcastNotificationService).to receive(:new).with(expected_payload).and_call_original
        video.save
      end

      it 'should broadcasts the correct payload to the ActionCable channel' do
        expected_payload = {
          type: "new_video",
          message: "New video has been shared",
          sender: user.username,
          title: video.title
        }

        expect(ActionCable.server).to receive(:broadcast).with("notifications_channel", expected_payload)
        video.save
      end
    end
  end
end
