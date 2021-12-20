class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActiveStorage::SetCurrent

  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  private

  def render_record_invalid(exception)
    render json: { errors: exception.record.errors.as_json }, status: :unprocessable_entity
  end

  def render_record_not_found(exception)
    render json: { errors: "Could not find #{exception.model} with the requested id" },
           status: :not_found
  end
end
