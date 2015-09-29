class CurrentBudgetPage < SitePrism::Page
  set_url "/view_current"

  def has_spending_limit_for? budget
  end

  def has_time_period_for? budget
  end

  def has_total_spending_for? budget
  end

  def has_status_for? budget
  end

  def has_list_of? costs
  end

  def has_list_of_categories_totals_for? costs
  end
end
