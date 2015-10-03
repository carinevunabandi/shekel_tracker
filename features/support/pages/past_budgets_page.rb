class PastBudgetsPage < SitePrism::Page
  set_url '/view_past'

  def has_row_for?(budget)
    has_css? 'td', text: "#{budget.from} - #{budget.to}"
    has_css? 'td', text: budget.spending_limit
    has_css? 'td', text: budget.total_spending
    has_css? 'td', text: (budget.overspent ? 'Yes' : 'No')
  end
end
