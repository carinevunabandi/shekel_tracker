require 'spec_helper'

describe Budget do
  describe '.past' do
    let!(:budgets) do
      [[1, '1-Jan-2010', '31-Jan-2010'],
       [2, '1-Feb-2010', '29-Feb-2010'],
       [3, '1-Mar-2010', '31-Mar-2010'],
       [4, '1-Apr-2010', '30-Apr-2010'],
       [5, '1-May-2010', '31-May-2010']].map do |number, from, to|
         create(:budget, :past,
                spending_limit: 700,
                total_spending: number * 200,
                overspent: (number * 200 > 700 ? true : false),
                from: from,
                to: to)
       end
    end

    it 'loads all past budgets from the database' do
      expect(Budget.past).to eq budgets
      Budget.past
    end
  end

  describe '#from_date' do
    let(:budget) { create(:budget, from: '01-01-2010') }

    it "calls the DateFormatter with this budget's from date" do
      expect(DateFormatter).to receive(:format).with(budget.from)
      budget.from_date
    end
  end

  describe '#to_date' do
    let(:budget) { create(:budget, to: '31-01-2010') }

    it "calls the DateFormatter with this budget's to date" do
      expect(DateFormatter).to receive(:format).with(budget.to)
      budget.to_date
    end
  end
end
