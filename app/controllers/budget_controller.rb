class ShekelTracker < Sinatra::Base
  get '/view_current' do
    @budget_wrapper = BudgetFacade.new(Budget.find_by(current: true))
    erb :'budget/current'
  end

  get '/budget/new' do
    erb :'budget/new'
  end

  post '/budget/new' do
    Budget.create(spending_limit: params['spending_limit'],
                  from: params['from'],
                  to: params['to'],
                  current: true,
                  total_spending: 0,
                  overspent: false)
    flash[:success] = 'Budget created'
    redirect :'/view_current'
  end

  get '/view_past' do
    budgets = Budget.past
    @budget_wrappers = budgets.map { |budget| BudgetFacade.new(budget) }
    erb :'budget/list'
  end
end
