class ApplicationController < ActionController::API
  respond_to :json
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Exception do |e|
    render_json({ error: "Something went wrong: #{e.message}" }, :bad_request)
  end

  def render_json(data = {}, status = :ok)
    render json: data, status: status
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username email])
  end
end
