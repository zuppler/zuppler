Feature: Menu resource
  Menu resource

  @vcr
  Scenario: Create menu
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    When I create menu "lunch","desc","1"
    Then I should have menu created

  @vcr
  Scenario: Update menu
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a menu "22418"
    When I update menu with "mmm","ddd","true","1"
    Then I should get success response

  @vcr
  Scenario: Delete menu
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a menu "22418"
    When I delete menu
    Then I should get success response
