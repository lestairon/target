require 'rails_helper'

RSpec.describe 'Target', type: :request do
  describe 'create a new target' do
    let(:headers) { user.create_new_auth_token }
    let(:target_params) { {} }
    let(:user) { create(:user) }
    let(:topic) { create(:topic) }
    let(:title) { Faker::Science.science }
    let(:radius) { Faker::Number.between(from: 1, to: 1000) }
    let(:longitude) { Faker::Address.longitude.round(14).to_s }
    let(:latitude) { Faker::Address.latitude.round(14).to_s }
    let(:topic_id) { topic.id }

    subject { post api_v1_targets_path, params: target_params, headers: headers, as: :json }

    before do
      target_params.merge!({
                             topic_id: topic_id,
                             title: title,
                             radius: radius,
                             longitude: longitude,
                             latitude: latitude
                           })
    end

    context 'when passed correct params' do
      it 'persist a target record' do
        expect { subject }.to change { Target.count }.by(1)
      end

      it 'returns status code created' do
        subject

        expect(response).to have_http_status(:created)
      end

      it 'returns the target in the response body' do
        subject
        parsed_response = JSON.parse(response.body)

        expect(parsed_response).to include(target_params.stringify_keys)
      end

      it 'associates the target to current_user' do
        subject

        expect(Target.last.user).to eq(user)
      end
    end

    context 'when params are incorrect' do
      before { subject }

      context 'when topic does not exist' do
        let(:topic_id) { nil }

        it 'returns unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when radius is incorrect' do
        let(:radius) { 'not a number' }

        it 'returns unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when title is incorrect' do
        let(:title) { nil }

        it 'returns unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when longitude is incorrect' do
        let(:longitude) { 'not a number' }

        it 'returns unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when latitude is incorrect' do
        let(:latitude) { 'not a number' }

        it 'returns unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when user is not logged in' do
      let(:headers) { {} }

      before { subject }

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
