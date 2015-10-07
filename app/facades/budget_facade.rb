class BudgetFacade
  attr_reader :budget

  def initialize(budget)
    @budget = budget
  end

  def url_path
    @budget ? "#{@budget.id}" : 'not_found'
  end

  def spending_limit
    @budget.spending_limit
  end

  def total_spending
    @budget.total_spending
  end

  def overspent?
    @budget.overspent ? 'Yes' : 'No'
  end

  def time_period
    "From #{@budget.from_date} to #{@budget.to_date}"
  end

  def costs
    @costs = @budget.costs
  end

  def categories_with_totals
    @categories = total_per_categories_for_costs
  end

  private

  def total_per_categories_for_costs
    cats_hash = {}
    costs.map(&:category).map do |category|
      cats_hash[category.name] = Cost.where(category: category).pluck(:price).reduce(:+)
    end
    cats_hash
  end
end
