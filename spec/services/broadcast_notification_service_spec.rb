require 'rails_helper'

RSpec.describe BroadcastNotificationService do
  let(:payload) do
    {
      type: "new_video",
      message: "New video has been shared",
      sender: "test_user",
      title: "Test Video Title"
    }
  end

  subject { described_class.new(payload) }

  describe "#execute" do
    context "when notification is successfully broadcasted" do
      it "should broadcast the notification and return true" do
        expect(ActionCable.server).to receive(:broadcast).with("notifications_channel", payload)

        result = subject.execute
        expect(result).to be true
      end
    end

    context "when an exception occurs during broadcast" do
      let(:error_message) { "Something went wrong!" }
      let(:exception) { StandardError.new(error_message) }

      before do
        allow(ActionCable.server).to receive(:broadcast).and_raise(exception)
      end

      it "should handle the exception and return false" do
        expect(Rails.logger).to receive(:error).with("Failed to broadcast notification: #{error_message}")
        expect(Rails.logger).to receive(:error).with(instance_of(String))

        result = subject.execute
        expect(result).to be false
      end
    end
  end
end
