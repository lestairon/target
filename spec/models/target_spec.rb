require 'rails_helper'

RSpec.describe Target, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:topic) }
    it { is_expected.to belong_to(:user) }
  end
end
