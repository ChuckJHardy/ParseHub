require 'spec_helper'

describe ParseHub::Ask do
  subject(:ask) { described_class.for(url: url, template: template) }

  let(:url) { 'http://google.com' }
  let(:template) { 'google' }
  let(:response) { double('Faraday::Response', body: { run_token: 'token' }) }

  it 'calls API with expected arguments' do
    expect(ParseHub::API).to receive(:post).with(
      domain: 'https://www.parsehub.com/api/v2/',
      url: 'projects/tn42b20lBQg4wYSAszFB6lop/run',
      options: {
        api_key: 'tYfV061ZLffZTaUiTeocGZHA',
        format: 'json',
        start_url: url,
        start_template: template
      }
    ) { response }

    expect(ask).to eq('token')
  end
end
