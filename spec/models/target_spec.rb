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

    context 'when user has reached target limit' do
      let(:user) { create(:user) }

      before { create_list(:target, 10, user: user) }

      it 'raises an error when creating a new target' do
        target = build(:target, user: user)

        expect(target).to_not be_valid
      end
    end

    context 'when user can create more targets' do
      let(:user) { create(:user) }

      it 'allows to create a new target for the user' do
        target = build(:target, user: user)

        expect(target).to be_valid
      end
    end
  end
end
