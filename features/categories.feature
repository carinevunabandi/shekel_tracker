Feature: Anything to do with categories

  @wip
  Scenario: Adding a new  category
    Given There are no categories in the category table
    When  I add a new category
    Then  There I should find that category if I search for it
