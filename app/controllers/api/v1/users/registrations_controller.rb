module Api
  module V1
    module Users
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        respond_to :json

        protected

        def render_create_success
          render json: resource_data, status: :created
        end
      end
    end
  end
end
