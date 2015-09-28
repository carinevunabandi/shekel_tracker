require 'spec_helper'

describe 'Viewing details about the current budget' do
  let(:budget)    { double(:current_budget, time_period_id: 2, amount: 600, current: true) }

  before do
    allow(Budget).to receive(:find_by).with(current: true).and_return(budget)
    allow(Cost).to receive(:total_for_period)
    allow(StatusTeller).to receive(:current)
    allow(Cost).to receive(:expenses_during)
    allow(Cost).to receive(:totals_per_categories)
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

  it 'retrieves the total spending per category given a budget period' do
    expect(Cost).to receive(:totals_per_categories).with(budget.time_period_id)
    get '/view_current'
  end
end

describe 'GET /budget/new' do
  it 'renders the budgets new page' do
    get '/budget/new'
    expect(last_response.body).to match(/New Budget/)
  end
end

describe 'POST /budget/new' do
  let(:params) do
    { 'from'   => '1-Aug-2015',
      'to'     => '31-Aug-2015',
      'amount' => '800' }
  end

  let(:time_period) do
    TimePeriod.new(from: params['from'],
                   to:   params['to'])
  end
  let(:budget) do
    Budget.new(time_period_id: time_period.id,
               amount:         params['amount'],
               current:        true)
  end

  before do
    allow(TimePeriod).to receive(:create).with(from: params['from'], to: params['to']).and_return(time_period)
    allow(Budget).to receive(:new).with(time_period_id: time_period.id,
                                        amount: params['amount'],
                                        current: true).and_return(time_period)
  end

  it 'should save the time period' do
    expect(TimePeriod).to receive(:create)
    post '/budget/new', params
  end

  it 'should save the budget' do
    expect(Budget).to receive(:create)
    post '/budget/new', params
  end

  it 'should redirect to the current budget page and shows a flash message' do
    post '/budget/new', params
    follow_redirect!
    expect(last_response).to match(/Budget created/)
  end
end


describe "Viewing list of past budgets" do
  let(:budgets) { double(:budgets) }

  it "loads all past budgets" do
    allow(Budget).to receive(:past).and_return(budgets)
    expect(Budget).to receive(:past).and_return(budgets)
    get '/view_past'
  end
end
