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
    get '/budget/current'
  end

  it 'creates a budget_facade with the current budget' do
    expect(BudgetFacade).to receive(:new).with(current_budget)
    get '/budget/current'
  end

  context 'There is an existing current budget in the db' do
    it "redirects to viewing the current's budget" do
      get '/budget/current'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq "/budget/#{current_budget.id}"
    end
  end

  context 'There is no existing current budget in the db' do
    current_budget = nil
    budget_wrapper = BudgetFacade.new(current_budget)

    it 'redirects to creating a new budget' do
      allow(Budget).to receive(:find_by).and_return(current_budget)
      allow(BudgetFacade).to receive(:new).and_return(budget_wrapper)
      get '/budget/current'
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_request.path).to eq '/budget/not_found'
    end
  end
end

describe 'Being prompted to create a new budget' do
  it 'prompts the user the create a new budget if there is no current one' do
    get '/budget/not_found'
    expect(last_response).to match(/No budgets defined yet! Create a new one/)
  end
end

describe 'Viewing list of past budgets' do
  let(:budgets) do
    [[1, '1-Jan-2010', '31-Jan-2010'],
     [2, '1-Feb-2010', '28-Feb-2010'],
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

  it 'loads all past budgets' do
    expect(Budget).to receive(:past).and_return(budgets)
    get '/budget/past'
  end

  it 'creates a budget_facade for each past budget' do
    allow(Budget).to receive(:past).and_return(budgets)
    budgets.each do |budget|
      budget_wrapper = BudgetFacade.new(budget)
      allow(BudgetFacade).to receive(:new).and_return(budget_wrapper)
      expect(BudgetFacade).to receive(:new).with(budget)
    end
    get '/budget/past'
  end
end

describe 'GET /budget/new' do
  it 'renders the create new budget page' do
    get '/budget/new'
    expect(last_response.body).to match(/New Budget/)
  end
end

describe 'GET /budget/:id' do
  let(:params)         { { 'id' => '1' } }
  let(:budget)         { create(:budget) }
  let(:budget_wrapper) { BudgetFacade.new(budget) }

  before do
    allow(Budget).to receive(:find).with('1').and_return(budget)
  end

  it 'loads the budget sepcified by the id' do
    expect(Budget).to receive(:find).with(params['id'])
    get '/budget/1'
  end

  it 'wraps the found budget into a budget_facade object' do
    allow(BudgetFacade).to receive(:new).and_return(budget_wrapper)
    expect(BudgetFacade).to receive(:new).with(budget)
    get '/budget/1'
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
    2.times { follow_redirect! }
    expect(last_response).to match(/Budget created/)
  end
end
