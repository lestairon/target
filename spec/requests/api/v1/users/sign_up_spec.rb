require 'rails_helper'

RSpec.describe 'User acount creation', type: :request do
  subject { post api_v1_user_registration_path, params: user_params, as: :json }

  context 'when attributes are good' do
    let(:user_email) { Faker::Internet.email }
    let(:user_params) do
      { email: user_email, password: Faker::Internet.password }
    end

    it 'returns created' do
      subject

      expect(response).to have_http_status(:created)
    end

    it 'creates the user' do
      expect { subject }.to change { User.count }.by(1)
    end
  end

  context 'when attributes are not correct' do
    let(:user_params) do
      { user: { mail: 'test@test.com', psswd: 'asd' } }
    end

    before { subject }

    it 'returns unprocessable entity' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
