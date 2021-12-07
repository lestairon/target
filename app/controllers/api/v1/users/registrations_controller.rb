module Api
  module V1
    module Users
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        respond_to :json

        protected

        def render_update_error_user_not_found
          render_error(401, I18n.t('devise_token_auth.sessions.user_not_found'),
                       status: :unauthorized)
        end

        def render_create_success
          render json: resource_data, status: :created
        end
      end
    end
  end
end
