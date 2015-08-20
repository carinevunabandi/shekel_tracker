require 'spec_helper'

describe Cost do
  let(:cost_1) { double(:cost_1, price: 10, time_period_id: 1) }
  let(:cost_2) { double(:cost_2, price: 20, time_period_id: 2) }
  let(:cost_3) { double(:cost_3, price: 30, time_period_id: 1) }

  describe '.total_for_period' do
    it 'loads all expenses that occured during the specified time period' do
      expect(Cost).to receive(:where).with(time_period_id: 1)
      subject.class.total_for_period(1)
    end

    it 'calculates the total costs for all expenses during a given period of time' do
      allow(Cost).to receive(:where).and_return([cost_1, cost_3])
      expect(Cost.total_for_period(1)).to eq 40
    end

    it 'returns zero if there are no costs for the given period of time' do
      allow(Cost).to receive(:where).and_return(nil)
      expect(Cost.total_for_period(1)).to eq 0
    end
  end

  describe '.expenses_during' do
    it 'gets costs that occured during a given period of time' do
      allow(Cost).to receive(:where).and_return([cost_1, cost_3])
      expect(Cost.expenses_during(1)).to eq ([cost_1, cost_3])
    end
  end

  describe '.totals_per_categories' do
    it 'fetches all expenses that occured during the specified time period' do
      expect(Cost).to receive(:where)
      subject.class.totals_per_categories(1)
    end

    it 'calculates the total for expenses in each category' do
      category_1 = Category.new(name: 'Food')
      category_2 = Category.new(name: 'Social')
      category_1.save
      category_2.save
      cost_1 = Cost.new(price: 10, description: 'Biscuits from Tesco', time_period_id: 1, category_id: category_1.id)
      cost_2 = Cost.new(price: 30, description: 'PayDay Drinks',       time_period_id: 1, category_id: category_2.id)
      cost_3 = Cost.new(price: 5,  description: 'Apples',              time_period_id: 1, category_id: category_1.id)
      cost_4 = Cost.new(price: 6,  description: 'Ann bday eat-out',    time_period_id: 1, category_id: category_2.id)
      cost_1 .save
      cost_2 .save
      cost_3 .save
      cost_4 .save
      total_costs_per_category = { 'Food' => 15, 'Social' => 36 }
      expect(subject.class.totals_per_categories(1)).to eq(total_costs_per_category)
    end

    it 'returns nil if there are no costs for the given period of time' do
      allow(Cost).to receive(:where).and_return(nil)
      expect(subject.class.totals_per_categories(1)).to eq(nil)
    end
  end
end
