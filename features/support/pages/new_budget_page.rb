class NewBudgetPage < SitePrism::Page
  set_url '/budget/new'

  element :from_date_field,      "input[name='from']"
  element :to_date_field,        "input[name='to']"
  element :spending_limit_field, "input[name='spending_limit']"
  element :create_button,        "button[type='submit']"
end
