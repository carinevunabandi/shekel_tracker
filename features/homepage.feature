Feature: Viewing the homepage

  Scenario: Visiting the homepage
    When I visit the homepage
    Then I should see the 'current budget' tab
    Then I should see 'previous budgets' tab
