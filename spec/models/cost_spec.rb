require 'spec_helper'

describe Cost do
  describe '.total_for_period' do
    let(:time_period) { double(:time_period, id: 1) }
    let(:cost_1) { double(:cost_1, price: 10, time_period_id: 1) }
    let(:cost_2) { double(:cost_2, price: 20, time_period_id: 2) }
    let(:cost_3) { double(:cost_3, price: 30, time_period_id: 1) }

    it 'loads all expenses that occured during the specified time period' do
      expect(Cost).to receive(:where).with(time_period_id: 1)
      subject.class.total_for_period(1)
    end

    it 'calculates the total costs for all expenses during a given period of time' do
      allow(Cost).to receive(:where).and_return([cost_1, cost_3])
      expect(Cost.total_for_period(time_period.id)).to eq 40
    end
  end
end
