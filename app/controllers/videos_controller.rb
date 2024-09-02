class VideosController < ApplicationController
  before_action :authenticate_user!, only: [ :create ]

  def index
    # total = Video.all.count
    videos = Video.includes(:user).all.order(created_at: :desc)
    data = VideoSerializer.new(videos, { include: [ :user ] }).serializable_hash

    render_json(data, :ok)
  end

  def create
    video_info = ExtractVideoInfoService.new(video_params[:url]).execute

    if video_info.blank?
      render_json({ errors: "Video not found or unavailable" }, :unprocessable_entity)
      return
    end

    video = current_user.videos.new(video_info)

    if video.save
      render_json(VideoSerializer.new(video, { include: [ :user ] }).serializable_hash, :ok)
    else
      render_json({ errors: video.errors.full_messages }, :unprocessable_entity)
    end
  end

  private

  def video_params
    params.require(:video).permit(Video::CREATE_PARAMS)
  end
end
