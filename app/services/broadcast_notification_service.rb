class BroadcastNotificationService
  def initialize(payload = {})
    @payload = payload
  end

  def execute
    send_notification
  end

  private
  def send_notification
    ActionCable.server.broadcast("notifications_channel", @payload)
  end
end
