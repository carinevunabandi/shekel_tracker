Feature: Creating and managing costs

  Scenario: Adding a new cost
    Given there is an existing current budget
    And   I am viewing that budget
    When  I fill in the form to create a new cost
    When  I click on add new cost
    Then  a new cost is created in the database
    And   that cost is added to the list of existing costs for the current budget
