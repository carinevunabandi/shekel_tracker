require 'spec_helper'

describe 'Viewing details about the current budget' do

  let(:budget_1) { double(:current_budget, time_period_id: 1, amount: 500, current: false) }
  let(:budget_2) { double(:current_budget, time_period_id: 2, amount: 600, current: true) }
  let(:cost_1)   { double(:cost_1, price: 10, time_period_id: 2) }
  let(:cost_2)   { double(:cost_2, price: 20, time_period_id: 2) }
  let(:cost_3)   { double(:cost_3, price: 40, time_period_id: 1) }

  before do
    allow(Budget).to receive(:find_by).with(current: true).and_return(budget_2)
    allow(Cost).to receive(:total_for_period)
    allow(StatusTeller).to receive(:current)
  end

  it 'retrieves the current budget' do
    expect(Budget).to receive(:find_by).and_return(budget_2)
    get '/view_current'
  end

  it "retrieves the current budget'amount" do
    get '/view_current'
    expect(last_response.body).to match(/600/)
  end

  it 'retrieves the total for all expenses so far' do
    allow(Cost).to receive(:total_for_period).and_return(30)
    get '/view_current'
    expect(last_response.body).to match(/30/)
  end

  it 'retrieves the status of the current budget' do
    allow(StatusTeller).to receive(:current).and_return("Within")
    get '/view_current'
    expect(last_response.body).to match(/Within budget/)
  end
end
