require 'spec_helper'

describe 'Viewing details about the current budget' do

  let(:budget)    { double(:current_budget, time_period_id: 2, amount: 600, current: true) }

  before do
    allow(Budget).to receive(:find_by).with(current: true).and_return(budget)
    allow(Cost).to receive(:total_for_period)
    allow(StatusTeller).to receive(:current)
    allow(Cost).to receive(:expenses_during)
  end

  it 'retrieves the current budget' do
    expect(Budget).to receive(:find_by).and_return(budget)
    get '/view_current'
  end

  it 'retrieves the total for all expenses so far' do
    expect(Cost).to receive(:total_for_period).with(budget.time_period_id).and_return(30)
    get '/view_current'
  end

  it 'retrieves the status of the current budget' do
    allow(Cost).to receive(:total_for_period).and_return(30)
    expect(StatusTeller).to receive(:current).with(budget.amount, 30)
    get '/view_current'
  end

  it 'retrieves all costs occured during the current budget' do
    expect(Cost).to receive(:expenses_during).with(budget.time_period_id)
    get '/view_current'
  end
end
