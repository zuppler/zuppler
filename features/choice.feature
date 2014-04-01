Feature: Choice resource
  Create/Update/Delete resource

  @vcr
  Scenario: Create category level choice
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1712"
    When I create choice "toppings cat","desc","true","5","2","true"
    Then I should have choice created

  @vcr
  Scenario: Create item level choice
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1712"
    And I have an item "1234"
    When I create choice "toppings item","desc","true","5","2","false"
    Then I should have choice created

  @vcr
  Scenario: Update choice
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a choice "69212"
    When I update choice "ddd","3","true","true","3","5"
    Then I should get success response

  @vcr
  Scenario: Delete choice
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a choice "69212"
    When I delete choice
    Then I should get success response
