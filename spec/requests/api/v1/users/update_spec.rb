require 'rails_helper'

RSpec.describe 'User account update', type: :request do
  let(:user) { create(:user) }
  let(:headers) { user.create_new_auth_token }
  let(:user_params) { {} }
  subject do
    patch api_v1_user_registration_path, as: :json, params: user_params, headers: headers
  end

  context 'when user is logged in' do
    context 'when updating name' do
      let(:new_name) { Faker::Name.name }
      let(:user_params) { { name: new_name } }

      it 'returns ok' do
        subject

        expect(response).to have_http_status(:ok)
      end

      it 'changes the name' do
        expect { subject }.to change { user.reload.name }.to(new_name)
      end
    end

    context 'when updating password' do
      let(:new_password) { Faker::Internet.password }
      let(:user_params) { { password: new_password } }

      it 'returns ok' do
        subject

        expect(response).to have_http_status(:ok)
      end

      it 'changes the password' do
        expect { subject }.to change { user.reload.encrypted_password }
      end
    end

    context 'when updating gender' do
      let(:new_gender) { Faker::Gender.binary_type.downcase }
      let(:user_params) { { gender: new_gender } }

      it 'returns ok' do
        subject

        expect(response).to have_http_status(:ok)
      end

      it 'changes the gender' do
        expect { subject }.to change { user.reload.gender }.to(new_gender)
      end
    end
  end

  context 'when user is not logged in' do
    let(:headers) { {} }
    let(:user_params) { { name: Faker::Name.name } }

    it 'returns unauthorized' do
      subject

      expect(response).to have_http_status(:not_found)
    end

    it 'does not change the user' do
      expect { subject }.to_not change { user.reload }
    end
  end
end
