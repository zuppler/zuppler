Feature: Menu resource
  Menu resource

  @vcr
  Scenario: create menu
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    When I create menu "lunch"
    Then I should have menu created
