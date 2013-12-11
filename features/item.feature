Feature: Item resource
  Create/Update item

  @vcr
  Scenario: Create item
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1712"
    When I create item with "margherita","9.99","small","1"
    Then I should have item created

  @vcr
  Scenario: Update item
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a menu "235"
    And I have a category "1712"
    When I update item "9898" with "diavolo","8.99","2"
    Then I should have item updated
    
