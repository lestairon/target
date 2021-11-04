module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json

        private

        def respond_to_on_destroy
          head :ok
        end
      end
    end
  end
end
