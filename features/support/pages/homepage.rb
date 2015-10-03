class Homepage < SitePrism::Page
  set_url '/'

  element :past_budgets_link, :link, 'Past Budgets'
  element :current_budget_link, :link, 'Current Budget'

  def view_current
    current_budget_link.click
    CurrentBudgetPage.new
  end

  def view_past
    past_budgets_link.click
    PastBudgetsPage.new
  end
end
