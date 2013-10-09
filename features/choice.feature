Feature: Choice resource
  Choice resource

  @vcr
  Scenario: create category level choice
    Given Zuppler configured with demorestaurant and qwe123
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1713"
    When I create choice "toppings"
    Then I should have choice created

  @vcr
  Scenario: create item level choice
    Given Zuppler configured with demorestaurant and qwe123
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1713"
    And I have an item "1234"
    When I create choice "toppings"
    Then I should have choice created
