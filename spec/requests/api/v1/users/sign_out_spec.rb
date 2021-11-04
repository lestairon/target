require 'rails_helper'

RSpec.describe 'User sign out', type: :request do
  let(:user) { create(:user) }

  subject { delete destroy_api_v1_user_session_path, headers: user_tokens, as: :json }

  context 'when user tokens are correct' do
    let(:user_tokens) { user.create_new_auth_token }

    before { subject }

    it 'returns status code ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns success true in the body' do
      expect(response.body).to eq({ success: true }.to_json)
    end

    context 'when the user is already signed out' do
      before { delete destroy_api_v1_user_session_path, headers: user_tokens, as: :json }

      it 'returns not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns the corresponding error' do
        expect(response.body).to eq(
          {
            success: false,
            errors: ['User was not found or was not logged in.']
          }.to_json
        )
      end
    end
  end

  context 'when user tokens are incorrect' do
    let(:user_tokens) { user.create_new_auth_token }

    before do
      user_tokens.merge!('access-token': 'incorrect_token')
      subject
    end

    it 'returns not found status code' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
