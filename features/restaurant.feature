Feature: Restaurant resource
  Client uses this resource to create/update a restaurant.

  Scenario: Check zuppler initialization
    Given Zuppler is loaded
    When Zuppler is not initialized
    Then Restaurants should raise error

  @vcr
  Scenario: Create restaurant
    Given Zuppler configured with "zuppler" and "abcd"
    When I create "Restaurant", "102 Church Ave, College Station, 77840" restaurant
    Then I should have oscar restaurant

  @vcr
  Scenario: Find restaurant
    When I find restaurant "demorestaurant"
    Then I should have "demorestaurant" restaurant
    


    

