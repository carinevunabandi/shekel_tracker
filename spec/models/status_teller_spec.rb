require 'rspec'

describe StatusTeller do
  describe '.current' do
    it "returns within if budget is greater than total spendings" do
      expect(StatusTeller.current(500,40)).to eq 'Within'
    end

    it "returns 'beyond' if budget is greater than total spendings" do
      expect(StatusTeller.current(500,510)).to eq 'Beyond'
    end
  end
end
