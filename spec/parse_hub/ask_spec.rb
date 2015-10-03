require 'spec_helper'

describe ParseHub::Ask do
  subject(:ask) do
    described_class.for(project_key: 'MY_PROJECT_KEY', url: url, template: template)
  end

  let(:url) { 'http://google.com' }
  let(:template) { 'google' }
  let(:response) { double('Faraday::Response', body: { run_token: 'token' }) }

  it 'calls API with expected arguments' do
    expect(ParseHub::API).to receive(:post).with(
      domain: 'https://www.parsehub.com/api/v2/',
      url: 'projects/MY_PROJECT_KEY/run',
      options: {
        api_key: 'MY_API_KEY',
        format: 'json',
        start_url: url,
        start_template: template
      }
    ) { response }

    expect(ask).to eq('token')
  end
end
