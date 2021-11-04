module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        private

        def respond_with(resource, _opts = {})
          if resource.persisted?
            render json: resource
          else
            render json: { text: 'Failed to create account' }, status: :bad_request
          end
        end
      end
    end
  end
end
