Feature: Creating and managing budgets

  Background:
    Given there are categories in the database

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

  Scenario: Viewing a budget
    Given there is a budget with associated costs
    When  I view that budget
    Then  I see the spending limit for that budget
    And   I see the time period for that budget
    And   I see the total amount spent for that budget
    And   I see the state of the spending rate for that budget
    And   I see the list of expenses during that budget's time period
    And   I see the list of total spending per category for that budget
