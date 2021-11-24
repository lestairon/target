class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActiveStorage::SetCurrent

  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  private

  def render_record_invalid(exception)
    render json: { errors: exception.record.errors.as_json }, status: :unprocessable_entity
  end
end
