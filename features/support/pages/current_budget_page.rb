class CurrentBudgetPage < SitePrism::Page
  set_url '/view_current'

  def has_spending_limit_for?(budget)
    has_text? budget.spending_limit
  end

  def has_time_period_for?(budget)
    has_text? "#{budget.from_date}"
    has_text? "#{budget.to_date}"
  end

  def has_total_spending_for?(budget)
    has_text? budget.total_spending
  end

  def has_status_for?(budget)
    has_text? budget.overspent ? 'Yes' : 'No'
  end

  def has_list_of?(costs)
    costs.each do |cost|
      has_css? 'td', text: cost.price
      has_css? 'td', text: cost.description
      has_css? 'td', text: cost.date
      has_css? 'td', text: cost.category
    end
  end

  def has_list_of_categories_totals_for?(costs)
    distinct_categories(costs).each do |category|
      has_text? category
      has_text? total_for_category(costs, category)
    end
  end

  private

  def distinct_categories(costs)
    costs.map(&:category).uniq
  end

  def total_for_category(costs, category)
    costs.select { |cost| cost.category == category }.map(&:price).reduce(:+)
  end
end
