require 'rails_helper'

RSpec.describe Target, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:topic) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it do
      is_expected.to validate_numericality_of(:longitude).is_less_than(180).is_greater_than(-180)
      is_expected.to validate_numericality_of(:latitude).is_less_than(90).is_greater_than(-90)
      is_expected.to validate_numericality_of(:radius).only_integer
    end
  end
end
