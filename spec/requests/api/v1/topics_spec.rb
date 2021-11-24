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

      it 'returns the id in the body response' do
        expect(parsed_response.first).to have_key('id')
      end

      it 'returns the name in the body response' do
        expect(parsed_response.first).to have_key('name')
      end

      it 'returns the image_url in the body response' do
        expect(parsed_response.first).to have_key('image_url')
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
