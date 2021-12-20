class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActiveStorage::SetCurrent

  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name gender])
  end

  private

  def render_record_invalid(exception)
    render json: { errors: exception.record.errors.as_json }, status: :unprocessable_entity
  end

  def render_record_not_found(exception)
    render json: { errors: "Could not find #{exception.model} with the requested id" },
           status: :not_found
  end
end
