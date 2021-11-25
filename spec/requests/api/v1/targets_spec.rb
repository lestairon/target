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

  describe 'display list of targets' do
    let(:user) { create(:user) }
    let(:headers) { user.create_new_auth_token }
    let(:parsed_response) { JSON.parse(response.body) }

    subject { get api_v1_targets_path, as: :json, headers: headers }

    context 'when user has targets' do
      let(:num_of_targets) { Faker::Number.between(from: 1, to: 10) }
      let!(:targets) { create_list(:target, num_of_targets, user: user) }

      before { subject }

      it 'returns status code ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns all the user targets' do
        expect(parsed_response.size).to eq(num_of_targets)
      end

      it 'returns the targets id' do
        expect(parsed_response).to all(have_key('id'))
      end

      it 'returns the targets title' do
        expect(parsed_response).to all(have_key('title'))
      end

      it 'returns the target longitude' do
        expect(parsed_response).to all(have_key('longitude'))
      end

      it 'returns the target latitude' do
        expect(parsed_response).to all(have_key('latitude'))
      end

      it 'returns the target radius' do
        expect(parsed_response).to all(have_key('radius'))
      end

      it 'returns all the targets' do
        targets_ids = parsed_response.map { |target| target['id'] }

        expect(targets_ids).to match_array(targets.map(&:id))
      end
    end

    context 'when user does not have targets' do
      before { subject }

      it 'returns an empty array' do
        expect(parsed_response.size).to be_zero
      end
    end

    context 'when user is not signed in' do
      let(:headers) { {} }

      before { subject }

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
