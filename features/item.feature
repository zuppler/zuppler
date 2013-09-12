Feature: Item resource
  Create/Update item

  @vcr
  Scenario: Create item
    Given Zuppler configured with demorestaurant and qwe123
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "31788"
    When I create item with "margherita","9.99"
    Then I should have item created
    
