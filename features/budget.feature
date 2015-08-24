Feature: Anything to do with displaying/managing actual monthly budgets

  Scenario: Viewing the current month's budget
    Given there are costs for the current month
    And I am on the homepage
    When I click on this month's budget's link
    Then I should see the monthly budget amount
    And I should see the amount used so far
    And I should see the status of my current spending
    And I should see the list of expenses during that period of time
    And I should see the total spending per category

    @wip
  Scenario: Creating a new budget
    Given There is no current budget
    When  I want to create a new one
    And   I enter details for the new budget and submit
    Then  The new budget should be created
    And   I should see a confirmation text and be redirected to viewing it
