require 'rails_helper'

RSpec.describe 'Topics', type: :request do
  describe 'displays list of topics' do
    let(:parsed_response) { JSON.parse(response.body) }

    subject { get api_v1_topics_path, as: :json }

    context 'when there are topics' do
      let(:topics_number) { Faker::Number.between(from: 1, to: 100) }

      before do
        create_list(:topic, topics_number)
        subject
      end

      it 'returns all persisted topics' do
        expect(parsed_response.size).to eq(topics_number)
      end
    end

    context 'when there are no topics' do
      before { subject }

      it 'returns an empty array' do
        expect(parsed_response).to eq([])
      end
    end
  end
end
