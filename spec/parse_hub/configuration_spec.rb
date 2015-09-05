require 'spec_helper'

describe ParseHub::Configure do
  let(:instance) { Class.new { extend ParseHub::Configure } }

  describe '#base_url' do
    subject { instance.configuration.base_url }

    let(:new_url) { 'https://www.parsehub.com/api/v5' }

    it 'returns default' do
      expect(subject).to eq('https://www.parsehub.com/api/v2/')
    end

    it 'returns altered' do
      instance.configure { |config| config.base_url = new_url }
      expect(subject).to eq(new_url)
    end
  end

  describe '#api_key' do
    subject { instance.configuration.api_key }

    let(:new_api_key) { '123' }

    it 'returns default' do
      expect(subject).to eq(nil)
    end

    it 'returns altered' do
      instance.configure { |config| config.api_key = new_api_key }
      expect(subject).to eq(new_api_key)
    end
  end

  describe '#project_key' do
    subject { instance.configuration.project_key }

    let(:new_api_key) { '123' }

    it 'returns default' do
      expect(subject).to eq(nil)
    end

    it 'returns altered' do
      instance.configure { |config| config.project_key = new_api_key }
      expect(subject).to eq(new_api_key)
    end
  end

  describe '#clean' do
    subject { instance.configuration.clean }

    it 'returns default' do
      expect(subject).to eq(false)
    end

    it 'returns altered' do
      instance.configure { |config| config.clean = true }
      expect(subject).to eq(true)
    end
  end

  describe '#verbose' do
    subject { instance.configuration.verbose }

    it 'returns default' do
      expect(subject).to eq(false)
    end

    it 'returns altered' do
      instance.configure { |config| config.verbose = true }
      expect(subject).to eq(true)
    end
  end

  describe '#log' do
    subject { instance.configuration.log }

    it 'returns default' do
      expect(subject).to eq(false)
    end

    it 'returns altered' do
      instance.configure { |config| config.log = true }
      expect(subject).to eq(true)
    end
  end

  describe '#logger' do
    subject { instance.configuration.logger }

    it 'returns default' do
      expect(subject).to be_an_instance_of(Logger)
    end

    it 'returns altered' do
      instance.configure { |config| config.logger = nil }
      expect(subject).to be_nil
    end
  end
end
