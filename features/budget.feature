Feature: Anything to do with displaying/managing actual monthly budgets

  @wip
  Scenario: Viewing the current month's budget
    Given I am on the homepage
    When I click on this month's budget's link
    Then I should see the monthly budget amount
    And I should see the amount used so far
    And I should see the status of my current spending
    And I should see the total spending per category
