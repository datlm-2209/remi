module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      token = request.params[:token]
      return reject_unauthorized_connection unless token

      decoded_token = ::DecodeJwtTokenService.new(token).execute
      return reject_unauthorized_connection unless decoded_token

      User.find_by(id: decoded_token[:sub]) || reject_unauthorized_connection
    end

    # def extract_token_from_header
    #   request.headers[:HTTP_SEC_WEBSOCKET_PROTOCOL]&.split&.last
    # end
  end
end
