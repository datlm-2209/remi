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
    context 'after_create callback' do
      let(:user) { create(:user, username: "test_user") }
      let(:video) { build(:video, user: user, title: "Test Video") }

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
