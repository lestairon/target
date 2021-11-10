require 'rails_helper'

RSpec.describe 'User login', type: :request do
  before do
    post api_v1_user_session_path, params: user_params, as: :json
  end

  context 'when user credentials are correct' do
    let(:password) { Faker::Internet.password }
    let(:user) { User.create!(attributes_for(:user, password: password)) }
    let(:user_params) { { email: user.email, password: password } }

    it 'returns ok status with authorization token' do
      expect(response).to have_http_status(:created)
      expect(response.body).to eq({ message: 'Logged in successfully.' }.to_json)
      # binding.pry
      expect(response.headers).to have_key('client')
      expect(response.headers).to have_key('access-token')
    end
  end

  context 'when user credentials are incorrect' do
    let(:user_params) { { email: 'non-existent@mail.com', password: '2' } }

    it 'returns invalid credentials error' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
