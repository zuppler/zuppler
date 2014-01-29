Feature: Category resource
  Create/Update category

  @vcr
  Scenario: Create category
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a menu "21382"
    When I create category with "pizzas","desc","1","true"
    Then I should have category created
