require 'spec_helper'

describe ParseHub::DTO do
  let(:instance) { described_class.new(options: options) }
  let(:options) { { something: :else } }

  describe '.get' do
    subject { described_class.get(options) }

    let(:domain) { 'https://example.com' }
    let(:endpoint) { '/endpoint' }

    before do
      allow_any_instance_of(described_class).to receive(:domain) { domain }
      allow_any_instance_of(described_class).to receive(:endpoint) { endpoint }

      ParseHub.configuration.log = true
      expect(ParseHub.configuration.logger).to receive(:info)
    end

    it 'calls off to API and returns response body' do
      expect(ParseHub::API).to receive(:get).with(
        domain: domain,
        url: endpoint,
        options: {
          api_key: 'MY_API_KEY',
          format: 'json'
        }
      ) { double(body: {}) }

      expect(subject).to eq({})
    end

    after do
      ParseHub.configuration.log = false
    end
  end

  describe '.post' do
    subject { described_class.post(options) }

    let(:domain) { 'https://example.com' }
    let(:endpoint) { '/endpoint' }

    before do
      allow_any_instance_of(described_class).to receive(:domain) { domain }
      allow_any_instance_of(described_class).to receive(:endpoint) { endpoint }
    end

    it 'calls off to API and returns response body' do
      expect(ParseHub::API).to receive(:post).with(
        domain: domain,
        url: endpoint,
        options: {
          api_key: 'MY_API_KEY',
          format: 'json'
        }
      ) { double(body: {}) }

      expect(subject).to eq({})
    end
  end

  describe '.delete' do
    subject { described_class.delete(options) }

    let(:domain) { 'https://example.com' }
    let(:endpoint) { '/endpoint' }

    before do
      allow_any_instance_of(described_class).to receive(:domain) { domain }
      allow_any_instance_of(described_class).to receive(:endpoint) { endpoint }
    end

    it 'calls off to API and returns response body' do
      expect(ParseHub::API).to receive(:delete).with(
        domain: domain,
        url: endpoint,
        options: {
          api_key: 'MY_API_KEY',
          format: 'json'
        }
      ) { double(body: {}) }

      expect(subject).to eq({})
    end
  end

  describe '#params' do
    it 'returns empty hash' do
      expect(instance.params).to eq({})
    end
  end

  describe '#endpoint' do
    let(:msg) { 'Inheriting class must implement' }

    it 'raises an error' do
      expect { instance.endpoint }.to raise_error(NotImplementedError, msg)
    end
  end
end
