require 'spec_helper'

describe 'Viewing details about the current budget' do

  let(:budget_1)   { double(:current_budget, time_period_id: 1, amount: 500, current: false) }
  let(:budget_2)   { double(:current_budget, time_period_id: 2, amount: 600, current: true) }
  let(:category_1) { double(:category_1, name: 'Social') }
  let(:category_2) { double(:category_2, name: 'Food') }
  let(:cost_1)     { double(:cost_1, price: 10, description: "PayDay drinks", category_id: 1, date: "24-June-2015", time_period_id: 2) }
  let(:cost_2)     { double(:cost_2, price: 20, description: "Celery Bunch", category_id: 2, date: "4-June-2015", time_period_id: 2) }
  let(:cost_3)     { double(:cost_3, price: 40, description: "Restaurant with bae", category_id: 1, date: "3-May-2015", time_period_id: 1) }

  before do
    allow(Budget).to receive(:find_by).with(current: true).and_return(budget_2)
    allow(Cost).to receive(:total_for_period)
    allow(StatusTeller).to receive(:current)
    allow(Cost).to receive(:expenses_during)
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

  it 'retrieves all costs occured during the current budget' do
    allow(Cost).to receive(:expenses_during).with(2).and_return([cost_1, cost_2])
    get '/view_current'
    expect(last_response.body).to match(/PayDay drinks/)
    expect(last_response.body).to match(/Celery Bunch/)
    expect(last_response.body).to match(/24-June-2015/)
    expect(last_response.body).to match(/4-June-2015/)
    expect(last_response.body).to match(/Social/)
    expect(last_response.body).to match(/Food/)
  end
end
