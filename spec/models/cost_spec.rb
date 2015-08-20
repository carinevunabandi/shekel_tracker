require 'spec_helper'

describe Cost do

  describe '.total_for_period' do
    it 'loads all expenses that occured during the specified time period' do
      expect(Cost).to receive(:where).with(time_period_id: 1)
      subject.class.total_for_period(1)
    end

    it 'calculates the total costs for all expenses during a given period of time' do
      allow(Cost).to receive(:where).and_return([cost_1, cost_3])
      expect(Cost.total_for_period(1)).to eq 40
    end
  end

  describe '.expenses_during' do
    it 'gets costs that occured during a given period of time' do
      allow(Cost).to receive(:where).and_return([cost_1, cost_3])
      expect(Cost.expenses_during(1)).to eq ([cost_1, cost_3])
    end
  end
end
