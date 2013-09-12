Feature: Category resource
  Create/Update category

  @vcr
  Scenario: Create category
    Given Zuppler configured with demorestaurant and qwe123
    And I have a restaurant with "1","demorestaurant"
    And I have a menu "235"
    When I create category with "pizzas"
    Then I should have category created
