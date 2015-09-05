require 'spec_helper'

describe ParseHub::Answer do
  subject(:answer) { described_class.for(token: token) }

  let(:token) { 'tE2e9y7J-eyFiOAKaivrxsMl' }
  let(:response) { double('Faraday::Response', body: {}) }

  it 'calls API with expected arguments' do
    expect(ParseHub::API).to receive(:get).with(
      domain: 'https://www.parsehub.com/api/v2/',
      url: "runs/#{token}/data",
      options: {
        api_key: 'MY_API_KEY',
        format: 'json'
      }
    ) { response }

    expect(answer).to eq({})
  end
end
