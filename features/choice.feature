Feature: Choice resource
  Choice resource

  @vcr
  Scenario: create category level choice
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1712"
    When I create choice "toppings","true","5","2"
    Then I should have choice created

  @vcr
  Scenario: create item level choice
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1712"
    And I have an item "1234"
    When I create choice "toppings","true","5","2"
    Then I should have choice created
