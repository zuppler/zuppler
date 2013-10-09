Feature: Modifier resource
  Modifier resource

  @vcr
  Scenario: create modifier
    Given Zuppler configured with demorestaurant and qwe123
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1713"
    And I have a choice "66913"
    When I create modifier "cheese", "0.99"
    Then I should have modifier created
