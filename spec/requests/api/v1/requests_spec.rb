require 'rails_helper'

RSpec.describe 'Requests', type: :request do
  let(:user) { create(:user) }

  describe 'creating a new request' do
    let(:headers) { user.create_new_auth_token }
    let(:request_params) { {} }

    subject { post api_v1_requests_path, as: :json, headers: headers, params: request_params }

    context 'when a user is logged in' do
      let(:request_params) { { text: Faker::Lorem.paragraph } }

      it 'returns created' do
        subject

        expect(response).to have_http_status(:created)
      end

      it 'creates a new request' do
        expect { subject }.to change(Request, :count).by(1)
      end
    end

    context 'when a user is not logged in' do
      let(:headers) { {} }

      before { subject }

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
