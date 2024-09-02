class ExtractVideoInfoService
  attr_reader :url, :video

  def initialize(url)
    @url = url
  end

  def execute
    return unless valid_video_url?

    extract_video_info if video_available?
  end

  private
  def valid_video_url?
    VideoInfo.valid_url?(url)
  end

  def video_available?
    @video = VideoInfo.new(url)
    video.available?
  end

  def extract_video_info
    {
      url: url,
      title: video.title,
      description: video.description,
      embed_url: video.embed_url
    }
  end
end
