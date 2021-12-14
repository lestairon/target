require 'rails_helper'

RSpec.describe GetNearTargetsService, type: :service do
  describe '#call' do
    let(:user) { create(:user) }
    let(:target) { create(:target, radius: 500_000, user: user) }

    subject { described_class.call(target) }

    context 'when targets are in each others radius' do
      let!(:other_user_target) do
        create(:target, radius: 500_000_000, user: user, longitude: target.longitude,
                        latitude: target.latitude)
      end
      let!(:target_in_radius) do
        create(:target, longitude: target.longitude + 1, latitude: target.latitude, radius: 500_000)
      end

      it { is_expected.to contain_exactly(target_in_radius) }

      it 'does not return own targets' do
        expect(subject).to_not include(other_user_target)
      end
    end

    context 'when target does not have another nearby target' do
      let(:target_outside_radius) { create(:target, longitude: 180, latitude: 90) }

      it { is_expected.to be_empty }
    end

    context 'when theres only one target' do
      it { is_expected.to be_empty }
    end
  end
end
