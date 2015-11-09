Feature: Ingredient resource
  Ingredient resource

  @vcr
  Scenario: Create ingredient
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1713"
    And I have a choice "66913"
    When I create ingredient "cheese","desc","0.99","small","2"
    Then I should have ingredient created

  @vcr
  Scenario: Update ingredient
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a choice "85100"
    And I have a ingredient "812695"
    When I update ingredient "812695" with "cream","1.99","1","true"
    Then I should get success response

  @vcr
  Scenario: Delete ingredient
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a ingredient "1"
    When I delete ingredient
    Then I should get success response
