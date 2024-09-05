require 'rails_helper'

RSpec.describe ExtractVideoInfoService do
  let(:valid_url) { "https://www.youtube.com/watch?v=dQw4w9WgXcQ" }
  let(:invalid_url) { "invalid_url" }
  let(:video_info) do
    instance_double("VideoInfo",
      available?: true,
      title: "Rick Astley - Never Gonna Give You Up",
      description: "Official video of Rick Astley.",
      embed_url: "https://www.youtube.com/embed/dQw4w9WgXcQ")
  end

  subject { described_class.new(valid_url) }

  describe "#execute" do
    context "when the URL is valid and the video is available" do
      before do
        allow(VideoInfo).to receive(:valid_url?).with(valid_url).and_return(true)
        allow(VideoInfo).to receive(:new).with(valid_url).and_return(video_info)
      end

      it "should return video information" do
        result = subject.execute

        expect(result).to eq(
          {
            url: valid_url,
            title: "Rick Astley - Never Gonna Give You Up",
            description: "Official video of Rick Astley.",
            embed_url: "https://www.youtube.com/embed/dQw4w9WgXcQ"
          }
        )
      end
    end

    context "when the URL is invalid" do
      before do
        allow(VideoInfo).to receive(:valid_url?).with(invalid_url).and_return(false)
      end

      it "should return nil" do
        service = described_class.new(invalid_url)
        expect(service.execute).to be_nil
      end
    end

    context "when the video is unavailable" do
      let(:unavailable_video) { instance_double("VideoInfo", available?: false) }

      before do
        allow(VideoInfo).to receive(:valid_url?).with(valid_url).and_return(true)
        allow(VideoInfo).to receive(:new).with(valid_url).and_return(unavailable_video)
      end

      it "should return nil" do
        result = subject.execute
        expect(result).to be_nil
      end
    end
  end
end
