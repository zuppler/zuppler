Feature: Choice resource
  Choice resource

  @vcr
  Scenario: create choice
    Given Zuppler configured with demorestaurant and qwe123
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1713"
    When I create choice "toppings"
    Then I should have choice created
