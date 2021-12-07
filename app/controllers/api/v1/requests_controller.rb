module Api
  module V1
    class RequestsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def create
        @request = current_api_v1_user.requests.create!(request_params)

        render status: :created
      end

      private

      def request_params
        params.require(:request).permit(:message)
      end
    end
  end
end
