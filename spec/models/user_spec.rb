require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive.scoped_to(:provider) }

    it 'does not allow to create more than 10 targets' do
      expect { create_list(:target, 11, user: subject) }.to(
        raise_error(RangeError, 'Exceeded number of targets limit')
      )
    end
  end
end
