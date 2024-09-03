require "rails_helper"

RSpec.describe VideosController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:video_params) { { video: { url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ" } } }
  let(:invalid_video_params) { { video: { url: "https://www.youtube.invalid/watch?v=dQw4w9WgXcQ" } } }

  describe "GET /videos" do
    before do
      Video.destroy_all
      FactoryBot.create_list(:video, 11, user: user)
    end

    context "unauthorized" do
      it "should return status code 200" do
        get :index
        expect(response.status).to eq 200
      end
    end

    context "listing videos" do
      it "should return a list of videos" do
        get :index

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq(
          VideoSerializer.new(
            Video.includes(:user).order(created_at: :desc), { include: [ :user ] }
          ).serializable_hash.to_json
        )
      end
    end
  end

  describe "POST /videos" do
    context "unauthorized" do
      it "should return status code 401" do
        post :create
        expect(response.status).to eq 401
      end
    end

    context "authorized" do
      before do
        sign_in user
      end

      context 'when video_info is blank' do
        before do
          allow_any_instance_of(ExtractVideoInfoService).to receive(:execute).and_return(false)
        end

        it 'should not create a new Video' do
          expect {
            post :create, params: invalid_video_params
          }.not_to change(Video, :count)
        end

        it 'should return an error response' do
          post :create, params: invalid_video_params
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)["errors"]).to eq("Video not found or unavailable.")
        end
      end

      context "when video is valid" do
        it "should create video successfully" do
          post :create, params: video_params

          expect(Video.count).to eq(1)
          expect(response).to have_http_status(:ok)
          expect(response.body).to eq(
            VideoSerializer.new(
              Video.first.reload, { include: [ :user ] }
            ).serializable_hash.to_json
          )
        end
      end

      context "when video is nil" do
        it 'should not create a new Video' do
          expect {
            post :create, params: { video: nil }
          }.not_to change(Video, :count)
        end

        it 'should return an error response' do
          post :create, params: { video: invalid_video_params }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)["errors"]).to eq("Video URL is required.")
        end
      end

      context "when video is empty string" do
        it 'should not create a new Video' do
          expect {
            post :create, params: { video: "" }
          }.not_to change(Video, :count)
        end

        it 'should return an error response' do
          post :create, params: { video: invalid_video_params }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)["errors"]).to eq("Video URL is required.")
        end
      end
    end
  end
end
