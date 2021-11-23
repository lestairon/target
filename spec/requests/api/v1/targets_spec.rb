require 'rails_helper'

RSpec.describe 'Target', type: :request do
  describe 'create a new target' do
    let(:headers) { {} }
    let(:target_params) { {} }

    subject { post api_v1_targets_path, params: target_params, headers: headers, as: :json }

    context 'when passed correct params' do
      let(:user) { create(:user) }
      let(:topic) { create(:topic) }
      let(:title) { Faker::Science.science }
      let(:radius) { Faker::Number.between(from: 1, to: 1000) }
      let(:longitude) { Faker::Address.longitude }
      let(:latitude) { Faker::Address.latitude }
      let(:headers) { user.create_new_auth_token }
      let(:target_params) do
        { topic_id: topic.id, title: title, radius: radius, longitude: longitude,
          latitude: latitude }
      end

      it 'persist a target record' do
        expect { subject }.to change { Target.count }.by(1)
      end

      it 'returns status code created' do
        subject

        expect(response).to have_http_status(:created)
      end

      it 'returns the target in the response body' do
        subject
        target = Target.last

        expect(response.body).to eq(target.to_json)
      end

      it 'associates the target to current_user' do
        subject

        expect(Target.last.user).to eq(user)
      end
    end

    context 'when bad target params' do
      let(:user) { create(:user) }
      let(:topic) { create(:topic) }
      let(:headers) { user.create_new_auth_token }
      let(:target_params) { { topic_id: topic.id } }

      before { subject }

      it 'returns unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user is not logged in' do
      before { subject }

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
