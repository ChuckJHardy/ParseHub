require 'vcr_helper'

describe ParseHub do
  describe '.new' do
    subject(:ph_new) { described_class.new(token: token) }

    let(:token) { '' }

    context 'when token is blank' do
      it 'raises error' do
        expect { ph_new }.to raise_error(ParseHub::MissingRunToken)
      end
    end

    context 'when token is nil' do
      let(:token) { nil }

      it 'raises error' do
        expect { ph_new }.to raise_error(ParseHub::MissingRunToken)
      end
    end
  end

  describe '.run' do
    subject(:run) { described_class.run(url: url, template: template) }

    let(:template) { 'property' }
    let(:url) do
      'http://www.rightmove.co.uk/property-for-sale/property-46240381.html'
    end

    it 'returns token' do
      VCR.use_cassette('valid/run') do
        expect(run).to eq('tE2e9y7J-eyFiOAKaivrxsMl')
      end
    end
  end

  describe '#promise' do
    let(:instance) { described_class.new(token: token) }
    let(:token) { 'tE2e9y7J-eyFiOAKaivrxsMl' }
    let(:trys) { 2 }

    it 'returns response body' do
      VCR.use_cassette('valid/run') do
        VCR.use_cassette('valid/answer') do
          VCR.use_cassette('valid/get') do
            VCR.use_cassette('valid/delete') do
              instance.promise(waits: nil, trys: trys) do |response|
                expect(response.keys.length).to be > 0
              end
            end
          end
        end
      end
    end
  end

  describe '#answer' do
    subject(:answer) { instance.answer }

    let(:instance) { described_class.new(token: token) }
    let(:token) { 'tE2e9y7J-eyFiOAKaivrxsMl' }

    it 'returns response body' do
      VCR.use_cassette('valid/answer') do
        expect(answer.keys.length).to be > 0
      end
    end
  end

  describe '#finished?' do
    subject(:finished) { instance.finished? }

    let(:instance) { described_class.new(token: token) }
    let(:token) { 'tE2e9y7J-eyFiOAKaivrxsMl' }

    it 'returns true' do
      VCR.use_cassette('valid/get') do
        expect(finished).to eq(true)
      end
    end

    context 'when run is not complete' do
      it 'returns false' do
        VCR.use_cassette('invalid/get') do
          expect(finished).to eq(false)
        end
      end
    end
  end

  describe '#get' do
    subject(:get) { instance.get }

    let(:instance) { described_class.new(token: token) }
    let(:token) { 'tE2e9y7J-eyFiOAKaivrxsMl' }

    it 'returns response body' do
      VCR.use_cassette('valid/get') do
        expect(get.keys.length).to be > 0
      end
    end
  end

  describe '#delete' do
    subject(:delete) { instance.delete }

    let(:instance) { described_class.new(token: token) }
    let(:token) { 'tE2e9y7J-eyFiOAKaivrxsMl' }

    it 'returns response body' do
      VCR.use_cassette('valid/delete') do
        expect(delete).to eq(token)
      end
    end
  end
end
