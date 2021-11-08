require 'rails_helper'

RSpec.describe 'User acount creation', type: :request do
  before { post api_v1_user_registration_path, params: user_params, as: :json }

  context 'when attributes are good' do
    let(:user_email) { Faker::Internet.email }
    let(:user_params) do
      { email: user_email, password: Faker::Internet.password }
    end

    it 'creates an user account' do
      expect(response).to have_http_status(:created)
      expect(User.count).to be(1)
      expect(User.find_by(email: user_email)).to_not be_nil
    end
  end

  context 'when attributes are not correct' do
    let(:user_params) do
      { user: { mail: 'test@test.com', psswd: 'asd' } }
    end

    it 'raises an error when trying to create the account' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
