Feature: Menu resource
  Menu resource

  @vcr
  Scenario: Create menu
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    When I create menu "lunch","1"
    Then I should have menu created
