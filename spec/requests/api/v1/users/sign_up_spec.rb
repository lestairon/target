require 'rails_helper'

RSpec.describe 'User acount creation', type: :request do
  subject { post api_v1_user_registration_path, params: user_params, as: :json }

  context 'when attributes are good' do
    let(:user_email) { Faker::Internet.email }
    let(:password) { Faker::Internet.password }
    let(:confirm_success_url) { Faker::Internet.url }
    let(:mails) { ActionMailer::Base.deliveries }
    let(:user_params) do
      { email: user_email, password: password, password_confirmation: password }
    end

    it 'returns created' do
      subject

      expect(response).to have_http_status(:created)
    end

    it 'creates the user' do
      expect { subject }.to change { User.count }.by(1)
    end

    it 'sends an email for confirmation' do
      expect { subject }.to change { mails.size }.by(1)
    end

    it 'sends the email to the email provided' do
      subject

      expect(mails.first.to.first).to eq(user_email)
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
