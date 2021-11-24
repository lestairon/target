module Api
  module V1
    class TargetsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def create
        @target = current_api_v1_user.targets.create!(target_params)

        render status: :created
      end

      def index
        @targets = current_api_v1_user.targets
      end

      private

      def target_params
        params.require(:target).permit(:title, :radius, :longitude, :latitude, :topic_id)
      end
    end
  end
end
