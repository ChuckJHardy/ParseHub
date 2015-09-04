require 'spec_helper'
require 'parse_hub/ask'

describe ParseHub::Ask do
  subject(:ask) { described_class.for(url: url, template: template) }

  let(:url) { 'http://google.com' }
  let(:template) { 'google' }
  let(:response) { double('Faraday::Response', body: 'token') }

  before do
    ParseHub.configuration.api_key = '123'
    ParseHub.configuration.project_key = '456'
  end

  it 'calls API with expected arguments' do
    expect(ParseHub::API).to receive(:post).with(
      domain: 'https://www.parsehub.com/api/v2/projects/456',
      url: '/run',
      options: {
        api_key: '123',
        format: 'json',
        start_url: url,
        start_template: template
      }
    ) { response }

    expect(ask).to eq('token')
  end
end

