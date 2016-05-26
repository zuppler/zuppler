require 'spec_helper'

describe 'Zuppler::Model' do
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
    class L < Zuppler::Model
    end

    before do
      logger = double
      expect(logger).to receive(:info).twice
      expect(logger).to receive(:debug).twice
      Zuppler.logger = logger
    end

    it 'logs' do
      L.new.log '', double(body: ''), {}
    end

    after do
      Zuppler.logger = nil
    end
  end
end
