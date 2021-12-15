class NotificateNearbyTargetsService < ApplicationService
  attr_reader :target

  def initialize(target)
    @target = target
  end

  def call
    nearby_targets.each do |target|
      NotificationsChannel.broadcast_to(
        target.user,
        title: "There's a new target nearby for  the topic #{target.topic_name}!",
        description: "Your target #{target.title} has a new compatible target"
      )
    end
  end

  private

  def nearby_targets
    GetNearTargetsService.call(target)
  end
end
