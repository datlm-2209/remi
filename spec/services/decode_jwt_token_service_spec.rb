require 'rails_helper'
require 'jwt'

RSpec.describe DecodeJwtTokenService do
  let(:valid_payload) { { user_id: 1, exp: Time.now.to_i + 4 * 3600 } }
  let(:secret_key) { Rails.application.credentials.fetch(:devise_jwt_secret_key) }
  let(:valid_token) { JWT.encode(valid_payload, secret_key, 'HS256') }
  let(:expired_payload) { { user_id: 1, exp: Time.now.to_i - 3600 } }
  let(:expired_token) { JWT.encode(expired_payload, secret_key, 'HS256') }
  let(:invalid_token) { "invalid.token.here" }

  subject { described_class.new(token) }

  describe "#execute" do
    context "when the token is valid" do
      let(:token) { valid_token }

      it "should decode the token and return the payload" do
        result = subject.execute
        expect(result).to eq(user_id: 1, exp: valid_payload[:exp])
      end
    end

    context "when the token is expired" do
      let(:token) { expired_token }

      it "should return false" do
        result = subject.execute
        expect(result).to be false
      end
    end

    context "when the token is invalid" do
      let(:token) { invalid_token }

      it "should return false" do
        result = subject.execute
        expect(result).to be false
      end
    end
  end
end
