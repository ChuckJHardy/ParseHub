require 'spec_helper'

describe ParseHub::Promise do
  let(:waits) { [10, 2] }
  let(:trys) { 4 }
  let(:answer) { -> { 'Answer' } }
  let(:finished) { -> { true } }
  let(:delete) { -> {} }

  let(:args) do
    {
      waits: waits,
      trys: trys,
      answer: answer,
      finished: finished,
      delete: delete
    }
  end

  it 'returns response when ready' do
    expect(finished).to receive(:call)
      .and_return(false, false, false, true)

    expect_any_instance_of(ParseHub::Promise).to receive(:sleep).with(10)
    expect_any_instance_of(ParseHub::Promise).to receive(:sleep).with(2)
    expect_any_instance_of(ParseHub::Promise).to receive(:sleep).with(5)

    described_class.run(args) do |response|
      expect(delete).to receive(:call)
      expect(response).to eq('Answer')
    end
  end

  context 'when loops are more than trys' do
    let(:trys) { 0 }

    it 'raises error' do
      expect { described_class.run(args) }
        .to raise_error(ParseHub::RunLoopsError)
    end
  end

  context 'without cleaning' do
    before do
      allow(ParseHub.configuration).to receive(:clean) { false }
    end

    it 'does not call delete' do
      described_class.run(args) do
        expect(delete).to_not receive(:call)
      end
    end
  end
end
