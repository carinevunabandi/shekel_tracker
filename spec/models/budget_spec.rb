require 'spec_helper'

describe Budget do
  let(:time_period) { double(:time_period, id: 1, from: '1-May-2015', to: '31-May-2015') }

  describe '.amount_for_range' do
    it 'tells what the budget for a given time period is' do
      Budget.create(time_period_id: 1, amount: 500)
      allow(TimePeriod).to receive_message_chain(:where, :time_period_id).and_return(1)
      expect(Budget.amount_for_range('1-May-2015', '31-May-2015')).to eq 500
    end
  end
end
