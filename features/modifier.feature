Feature: Modifier resource
  Modifier resource

  @vcr
  Scenario: Create modifier
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1713"
    And I have a choice "66913"
    When I create modifier "cheese", "0.99", "small", "2"
    Then I should have modifier created

  @vcr
  Scenario: Update modifier
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1712"
    And I have a choice "66913"
    When I update modifier "696696" with "cream","1.99","1","true"
    Then I should get success response

  @vcr
  Scenario: Delete modifier
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1712"
    And I have a choice "66913"
    And I have a modifier "696696"
    When I delete modifier
    Then I should get success response
