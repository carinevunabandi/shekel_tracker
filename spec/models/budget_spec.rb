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

  describe '.past' do
    let!(:budgets) do
      [[1, "1-Jan-2010", "31-Jan-2010"],
       [2, "1-Feb-2010", "29-Feb-2010"],
       [3, "1-Mar-2010", "31-Mar-2010"],
       [4, "1-Apr-2010", "30-Apr-2010"],
       [5, "1-May-2010", "31-May-2010"]].map do |number, from, to|
         create(:budget, :past_budget,
                spending_limit: 700,
                total_spending: number*200,
                overspent: overspent?(700, number),
                from: from,
                to: to)
       end
    end

    it 'loads all past budgets from the database' do
      expect(Budget.past).to eq budgets
      Budget.past
    end
  end
end

def overspent?(spending_limit, number)
  number*200 > spending_limit ? true : false
end
