class PastBudgetsPage < SitePrism::Page

  def has_row_for? budget
    has_css? "td", text: budget.date_text
    has_css? "td", text: budget.spending_limit
    has_css? "td", text: budget.total_spending
    has_css? "td", text: budget.overspent
  end
end
