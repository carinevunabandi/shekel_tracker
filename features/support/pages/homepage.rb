class Homepage < SitePrism::Page
  set_url '/'

  element :previous_budgets_link, :link, "Previous Budgets"

  def view_previous
    previous_budgets_link.click
    PreviousBudgetsPage.new
  end
end
