class Video < ApplicationRecord
  CREATE_PARAMS = %i[url]

  before_create :extract_video_info
  after_create :broadcast_notification

  belongs_to :user

  validates :url, presence: true

  private
  def broadcast_notification
    result = BroadcastNotificationService.new(
      {
        type: "new_video",
        message: "New video has been shared",
        sender: user.username,
        title: title
      }
    ).execute

    unless result
      Rails.logger.error("Notification broadcast failed for video: #{id}")
    end
  end


  def extract_video_info
    return if url.blank?

    video_info = ExtractVideoInfoService.new(url).execute

    if video_info.blank?
      errors.add(:base, "Video not found or unavailable.")
      throw(:abort)
    else
      self.title = video_info[:title]
      self.description = video_info[:description]
      self.embed_url = video_info[:embed_url]
    end
  end
end
