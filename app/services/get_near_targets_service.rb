class GetNearTargetsService < ApplicationService
  attr_reader :target, :radius

  def initialize(target)
    @target = target
    @radius = target.radius
  end

  def call
    nearby_targets.each_with_object([]) do |curr, arr|
      next unless target_in_reverse_radius?(curr)

      arr << curr
    end
  end

  private

  def radius_to_km(target)
    target.radius.fdiv(1000)
  end

  def nearby_targets
    target.nearbys(radius_to_km(target), units: :km).where.not(user_id: target.user_id)
  end

  def target_in_reverse_radius?(second_target)
    second_target.distance_from(target, :km) < radius_to_km(second_target)
  end
end
