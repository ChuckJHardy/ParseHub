require 'spec_helper'

describe ParseHub::Error do
  let(:instance) do
    described_class.new(
      domain: 'www',
      url: 'example.com',
      options: { query: 1 },
      status: 200,
      body: '{ "name" : "Test" }'
    )
  end

  describe '#message' do
    subject(:message) { instance.message }

    let(:expected_hash) do
      {
        domain: 'www',
        url: 'example.com',
        options: { query: 1 },
        response: {
          status: 200,
          body: '{ "name" : "Test" }'
        }
      }
    end

    it 'returns expected response' do
      expect(message).to eq(expected_hash)
    end
  end
end
