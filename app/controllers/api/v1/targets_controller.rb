module Api
  module V1
    class TargetsController < ApplicationController
      before_action :authenticate_api_v1_user!

      def create
        target = Target.new(target_params)
        target.user = current_api_v1_user

        if target.save
          render json: target, status: :created
        else
          render json: { status: :error, message: target.errors.full_messages.to_sentence },
                 status: :unprocessable_entity
        end
      end

      private

      def target_params
        params.require(:target).permit(:title, :radius, :longitude, :latitude, :topic_id)
      end
    end
  end
end
