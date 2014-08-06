Feature: Modifier resource
  Modifier resource

  @vcr
  Scenario: Create modifier
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    When I create modifier "toppings","desc","true","5","2"
    Then I should have modifier created

  @vcr
  Scenario: Update modifier
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a modifier "1"
    When I update modifier "updated","true","3","5","1"
    Then I should get success response

  @vcr
  Scenario: Delete modifier
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a modifier "1"
    When I delete modifier
    Then I should get success response
