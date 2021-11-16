require 'rails_helper'

RSpec.describe 'User login', type: :request do
  subject { post api_v1_user_session_path, params: user_params, as: :json }
  before { subject }

  context 'when user credentials are correct' do
    let(:password) { Faker::Internet.password }
    let(:user) { create(:user, password: password) }
    let(:email) { user.email }
    let(:user_params) { { email: email, password: password, password_confirmation: password } }

    it 'returns status code ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a client header key' do
      expect(response.header).to have_key('client')
    end

    it 'returns an access-token header key' do
      expect(response.headers).to have_key('access-token')
    end
  end

  context 'when user credentials are incorrect' do
    let(:password) { Faker::Internet.password }
    let(:user) { create(:user, password: password) }

    context 'when email is incorrect' do
      let(:user_params) do
        { email: 'incorrect-email@mail.com', password: password, password_confirmation: password }
      end

      it 'returns invalid credentials error' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when password is incorrect' do
      let(:user_params) { { email: user.email, password: 'incorrect-password' } }

      it 'returns invalid credentials error' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
