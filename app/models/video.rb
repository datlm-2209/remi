class Video < ApplicationRecord
  CREATE_PARAMS = %i[url]

  after_create :broadcast_notification

  belongs_to :user

  validates :url, presence: true

  private
  def broadcast_notification
    BroadcastNotificationService.new(
      {
        type: "new_video",
        message: "New video has been shared",
        sender: user.username,
        title: title
      }
    ).execute
  end
end
