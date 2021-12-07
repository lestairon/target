require 'rails_helper'

RSpec.describe 'Password reset', type: :request do
  let(:user) { create(:user) }
  let(:mails) { ActionMailer::Base.deliveries }
  let(:reset_params) { {} }

  subject { post api_v1_user_password_path, as: :json, params: reset_params }

  context 'when trying to recover an existing user' do
    let(:reset_params) { { email: user.email, redirect_url: '/' } }

    it 'returns ok' do
      subject

      expect(response).to have_http_status(:ok)
    end

    it 'sends an email' do
      expect { subject }.to change { mails.size }.by(1)
    end

    it 'sends the email to the email provided' do
      subject

      expect(mails.first.to.first).to eq(user.email)
    end

    it 'creates a new reset_password_token for user' do
      expect { subject }.to change { user.reload.reset_password_token }
    end
  end

  context 'when trying to recover non existing user' do
    let(:reset_params) { { email: Faker::Internet.email, redirect_url: '/' } }

    it 'returns not found' do
      subject

      expect(response).to have_http_status(:not_found)
    end

    it 'doesnt send any email' do
      expect { subject }.to_not change { mails.size }
    end
  end
end
