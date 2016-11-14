require 'spec_helper'

describe 'Zuppler::Model' do
  class M < Zuppler::Model
  end

  it 'should wrap create' do
    class R
      def self.create(_options = {})
        'create'
      end
      include Zuppler::Macros
    end
    expect(Zuppler).to receive(:check)
    expect(R.create).to eq('create')
  end

  describe '#log' do
    before do
      logger = double
      expect(logger).to receive(:info).twice
      expect(logger).to receive(:debug).twice
      Zuppler.logger = logger
    end

    it 'logs' do
      M.new.log '', double(body: ''), {}
    end

    after do
      Zuppler.logger = nil
    end
  end

  describe 'requires!' do
    it 'raises argument error' do
      m = M.new
      data = { name: 'n' }
      expect do
        m.requires! data, :name, :age
      end.to raise_error ArgumentError, "'age' is required"
    end
  end
end
