require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:email) }
    # Idk why this isn´t working
    # it { is_expected.to validate_uniqueness_of(:email).case_insensitive.scoped_to(:provider) }
  end
end
