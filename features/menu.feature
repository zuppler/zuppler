Feature: Menu resource
  Menu resource

  @vcr
  Scenario: create menu
    Given Zuppler configured with demorestaurant and qwe123
    And I have a restaurant with "1","demorestaurant"
    When I create menu "lunch"
    Then I should have menu created
