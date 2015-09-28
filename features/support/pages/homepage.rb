class Homepage < SitePrism::Page
  set_url '/'

  element :previous_budgets_link, :link, "Previous Budgets"

  def view_past
    previous_budgets_link.click
    PastBudgetsPage.new
  end
end
