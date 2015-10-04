Feature: Anything to do with budgets

  Scenario: Viewing the list of all budgets
    Given I am on the homepage
    And   there are budgets in the database
    When  I view past budgets
    Then  I see the list of all past budgets

  Scenario: Creating a new budget
    Given There is no current budget
    When  I want to create a new one
    And   I enter details for the new budget and submit
    Then  The new budget should be created
    And   I should see a confirmation text and be redirected to viewing it

  Scenario: Viewing the current month's budget
    Given there is a current budget
    And   there are costs for the current budget
    When  I view the current budget
    Then  I see the spending limit for that budget
    And   I see the current budget's time period
    And   I see the total amount spent so far
    And   I see the status of my spending
    And   I see the list of expenses during this budget's time
    And   I see the list of total spending per category
