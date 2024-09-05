class BroadcastNotificationService
  def initialize(payload = {})
    @payload = payload
  end

  def execute
    send_notification
  rescue StandardError => e
    handle_exception(e)
    false
  else
    true
  end

  private

  def send_notification
    ActionCable.server.broadcast("notifications_channel", @payload)
  end

  def handle_exception(exception)
    Rails.logger.error("Failed to broadcast notification: #{exception.message}")
    Rails.logger.error(exception.backtrace.join("\n"))
  end
end
