require 'spec_helper'

describe 'Viewing details about the current budget' do
  let!(:current_budget)   { create(:budget) }
  let(:budget_wrapper)    { BudgetFacade.new(current_budget) }

  before do
    allow(Budget).to receive(:find_by).and_return(current_budget)
    allow(BudgetFacade).to receive(:new).and_return(budget_wrapper)
  end

  it 'loads the current budget from the database' do
    expect(Budget).to receive(:find_by).with(current: true)
    get '/view_current'
  end

  it 'creates a budget_facade with the current budget' do
    expect(BudgetFacade).to receive(:new).with(current_budget)
    get '/view_current'
  end
end

describe 'Viewing list of past budgets' do
  let(:budgets) do
    [[1, '1-Jan-2010', '31-Jan-2010'],
     [2, '1-Feb-2010', '28-Feb-2010'],
     [3, '1-Mar-2010', '31-Mar-2010'],
     [4, '1-Apr-2010', '30-Apr-2010'],
     [5, '1-May-2010', '31-May-2010']].map do |number, from, to|
       create(:budget, :past_budget,
              spending_limit: 700,
              total_spending: number * 200,
              overspent: (number * 200 > 700 ? true : false),
              from: from,
              to: to)
     end
  end

  it 'loads all past budgets' do
    expect(Budget).to receive(:past).and_return(budgets)
    get '/view_past'
  end

  it 'creates a budget_facade for each past budget' do
    allow(Budget).to receive(:past).and_return(budgets)
    budgets.each do |budget|
      budget_wrapper = BudgetFacade.new(budget)
      allow(BudgetFacade).to receive(:new).and_return(budget_wrapper)
      expect(BudgetFacade).to receive(:new).with(budget)
    end
    get '/view_past'
  end
end

describe 'GET /budget/new' do
  it 'renders the create new budget page' do
    get '/budget/new'
    expect(last_response.body).to match(/New Budget/)
  end
end

describe 'POST /budget/new' do
  let(:params) do
    { 'from'           => '1-Aug-2015',
      'to'             => '31-Aug-2015',
      'spending_limit' => '800' }
  end

  it 'should save the newly created budget' do
    expect(Budget).to receive(:create).with(from: params['from'],
                                            to: params['to'],
                                            spending_limit: params['spending_limit'],
                                            current: true,
                                            total_spending: 0,
                                            overspent: false)

    post '/budget/new', params
  end

  it 'should redirect to the current budget page and shows a flash message' do
    post '/budget/new', params
    follow_redirect!
    expect(last_response).to match(/Budget created/)
  end
end
