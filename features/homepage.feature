Feature: Viewing the homepage

  Scenario: Visiting the homepage
    When I view the homepage
    Then I see the 'current budget' tab
    Then I see 'past budgets' tab
