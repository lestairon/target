module Api
  module V1
    module Users
      class SessionsController < DeviseTokenAuth::SessionsController
        respond_to :json

        protected

        def respond_to_on_destroy
          head :ok
        end
      end
    end
  end
end
