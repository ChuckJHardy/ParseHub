require 'vcr_helper'

describe ParseHub do
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
end
