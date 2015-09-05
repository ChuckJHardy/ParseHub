require 'spec_helper'

describe ParseHub::Validate do
  subject(:validator) do
    described_class.with(
      method: :get,
      domain: 'www',
      url: 'example.com',
      options: { query: 1 },
      response: response
    )
  end

  let(:response) { double('Faraday::Response', status: status, body: body) }
  let(:body) { 'Response Body' }
  let(:status) { 200 }

  before do
    ParseHub.configuration.log = true
    expect(ParseHub.configuration.logger).to receive(:info)
  end

  it 'returns true when nothing is wrong' do
    expect(validator).to be_truthy
  end

  describe 'When BadRequest' do
    let(:status) { 400 }

    it 'raises error' do
      expect { validator }.to raise_error(
        ParseHub::BadRequest
      ) do |e|
        expect(e.message).to eq(
          domain: 'www',
          url: 'example.com',
          options: { query: 1 },
          response: {
            status: status,
            body: body
          }
        )
      end
    end
  end

  describe 'When NotFound' do
    let(:status) { 404 }

    it 'raises error' do
      expect { validator }.to raise_error(
        ParseHub::NotFound
      ) do |e|
        expect(e.message).to eq(
          domain: 'www',
          url: 'example.com',
          options: { query: 1 },
          response: {
            status: status,
            body: body
          }
        )
      end
    end
  end

  describe 'When Unauthorized' do
    let(:status) { 401 }

    it 'raises error' do
      expect { validator }.to raise_error(
        ParseHub::UnauthorizedError
      ) do |e|
        expect(e.message).to eq(
          domain: 'www',
          url: 'example.com',
          options: { query: 1 },
          response: {
            status: status,
            body: body
          }
        )
      end
    end
  end

  describe 'When Service is Down' do
    let(:status) { 504 }

    it 'raises error' do
      expect { validator }.to raise_error(
        ParseHub::ServiceDownError
      ) do |e|
        expect(e.message).to eq(
          domain: 'www',
          url: 'example.com',
          options: { query: 1 },
          response: {
            status: status,
            body: body
          }
        )
      end
    end
  end

  after do
    ParseHub.configuration.log = false
  end
end
