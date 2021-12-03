require 'rails_helper'

RSpec.describe Request, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to define_enum_for(:status).with_values(%i[pending in_progress solved]) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
