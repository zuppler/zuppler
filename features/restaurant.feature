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
    Then I should have "oscar" restaurant

  @vcr
  Scenario: Find restaurant
    Given Zuppler configured with "zuppler" and "abcd"
    When I find restaurant "demorestaurant"
    Then I should have "demorestaurant" restaurant

  @vcr
  Scenario: Exist restaurant
    Given Zuppler configured with "zuppler" and "abcd"
    When I check if restaurant "demorestaurant" exists
    Then I should get success response
    When I check if restaurant "notfound" exists
    Then I should get failed response
  
  @vcr
  Scenario: Update restaurant
    Given Zuppler configured with "zuppler" and "abcd"
    When I update restaurant "demorestaurant" with "demo"
    Then I should have "demorestaurant" restaurant

  @vcr
  Scenario: Show restaurant
    Given Zuppler configured with "zuppler" and "qwe123"
    When I find restaurant "demorestaurant"
    When I fetch restaurant details
    Then I should have restaurant details

  @vcr
  Scenario: Publish restaurant
    Given Zuppler configured with "zuppler" and "abcd"
    When I publish restaurant "demorestaurant"
    Then I should get success response

  @vcr
  Scenario: Pause restaurant
    Given Zuppler configured with "zuppler" and "abcd"
    When I pause restaurant "demorestaurant"
    Then I should get success response

  @vcr
  Scenario: Resume restaurant
    Given Zuppler configured with "zuppler" and "abcd"
    When I resume restaurant "demorestaurant"
    Then I should get success response
    


    

