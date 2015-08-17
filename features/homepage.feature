Feature: Viewing the homepage

  @wip
  Scenario: Visiting the homepage
    When I visit the homepage
    Then I should see 'this month's budget' tab
    And  I should see 'View previous budgets' tab
