class ShekelTracker < Sinatra::Base
  get '/budget/current' do
    budget = Budget.find_by(current: true)
    @budget_wrapper = BudgetFacade.new(budget)
    redirect :"/budget/#{@budget_wrapper.url_path}"
  end

  get '/budget/new' do
    erb :'budget/new'
  end

  get '/budget/not_found' do
    erb :'budget/prompt_new'
  end

  get '/budget/past' do
    budgets = Budget.past
    @budget_wrappers = budgets.map { |budget| BudgetFacade.new(budget) }
    erb :'budget/list'
  end

  get '/budget/:id' do
    budget = Budget.find(params[:id])
    @budget_wrapper = BudgetFacade.new(budget)
    erb :'budget/show'
  end

  post '/budget/new' do
    Budget.create(spending_limit: params['spending_limit'],
                  from: params['from'],
                  to: params['to'],
                  current: true,
                  total_spending: 0,
                  overspent: false)
    flash[:success] = 'Budget created'
    redirect :'/budget/current'
  end
end
