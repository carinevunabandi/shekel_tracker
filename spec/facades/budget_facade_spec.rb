require 'spec_helper'

describe BudgetFacade do
  let(:budget)         { create(:budget) }
  let(:budget_facade)  { BudgetFacade.new(budget) }
  let(:costs)          { double(:costs) }

  describe '#budget' do
    it 'returns the wrapped budget object' do
      expect(budget_facade.budget). to eq budget
    end
  end

  describe '#url_path' do
    context 'There is an existing current budget' do
      it 'the id of the budget to be used as the fragment of a url' do
        expect(budget_facade.url_path). to eq "#{budget.id}"
      end
    end

    context 'There is no existing current budget' do
      budget = nil
      budget_facade = BudgetFacade.new(budget)
      it 'new to be used as the fragment of a url' do
        expect(budget_facade.url_path). to eq 'not_found'
      end
    end
  end

  describe '#spending_limit' do
    it 'returns the spending limit set for a budget' do
      expect(budget_facade.spending_limit).to eq 100
    end
  end

  describe '#total_spending' do
    it 'returns the overall total spending for a budget' do
      expect(budget_facade.total_spending).to eq 70
    end
  end

  describe '#overspent?' do
    it 'returns the status of the spending rate in a budget' do
      expect(budget_facade.overspent?).to eq 'No'
    end
  end

  describe '#time_period' do
    it 'returns the formatted time period over which this budget applies' do
      expect(budget_facade.time_period).to eq 'From 01-Jan-2010 to 31-Jan-2010'
    end

    it "gets the 'from' date value of the current budget" do
      expect(budget).to receive(:from_date)
      budget_facade.time_period
    end

    it "gets the 'to' date value of the current budget" do
      expect(budget).to receive(:to_date)
      budget_facade.time_period
    end
  end

  describe '#costs' do
    it 'returns the costs objects associated to a budget' do
      allow(budget).to receive(:costs).and_return(costs)
      expect(budget_facade.costs).to eq costs
    end
  end

  describe '#categories_with_totals' do
    let(:categories) { (1..3).map { |number| create(:category, name: "cat_#{number}") } }
    let(:costs) do
      (1..3).map do |number|
        create(:cost, category: categories[number - 1], price: number * 10)
      end
    end
    let(:cats_and_totals)  { { 'cat_1' => 10, 'cat_2' => 20, 'cat_3' => 30 } }

    it 'returns the totals per categories of costs associated to a budget' do
      allow(budget_facade).to receive(:costs).and_return(costs)
      expect(budget_facade.categories_with_totals).to eq cats_and_totals
    end
  end
end
