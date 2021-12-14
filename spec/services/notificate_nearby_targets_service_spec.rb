require 'rails_helper'

RSpec.describe NotificateNearbyTargetsService, type: :service do
  let(:target) { create(:target) }
  let(:nearby_target) { create(:target) }

  subject { described_class.call(target) }

  describe 'when nearby targets' do
    before do
      allow(GetNearTargetsService).to receive(:call).and_return([nearby_target])
    end

    it 'broadcast a notification for target user' do
      expect { subject }.to(
        have_broadcasted_to(nearby_target.user).from_channel(NotificationsChannel)
      )
    end
  end

  context 'when no nearby targets' do
    before do
      allow(GetNearTargetsService).to receive(:call).and_return([])
    end

    it 'does not broadcast notifications' do
      expect { subject }.to_not(
        have_broadcasted_to(nearby_target.user).from_channel(NotificationsChannel)
      )
    end
  end
end
