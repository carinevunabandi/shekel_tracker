require 'spec_helper'

describe 'Viewing details about the current budget' do
  let(:current_budget)   { double(:current_budget) }

  it 'loads the current budget from the database' do
    expect(Budget).to receive(:where).with(current: true)
    get '/view_current'
  end

  it 'creates a new budget_facade object with the current budget' do
    allow(Budget).to receive(:where).and_return(current_budget)
    expect(BudgetFacade).to receive(:new).with(current_budget)
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
