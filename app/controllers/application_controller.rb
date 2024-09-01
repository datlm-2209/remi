class ApplicationController < ActionController::API
  respond_to :json

  before_action :authenticate_user!

  # rescue_from Exception do |e|
  #   render_json({ error: "Something went wrong: #{e.message}" }, :bad_request)
  # end

  def render_json(data = {}, status = :ok)
    render json: data, status: status
  end
end
