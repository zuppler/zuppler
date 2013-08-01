Feature: Restaurant resource
  Client uses this resource to create/update a restaurant.

  Scenario: Check zuppler initialization
    Given Zuppler is loaded
    When Zuppler is not initialized
    Then Restaurants should raise error

  @vcr
  Scenario: Create restaurant
    Given Zuppler configured with demorestaurant and qwe123
    When I create oscar,123456,https://www.google.com/images/srpr/logo4w.png,123 North St New York,Syca,syca@zuppler.com,0745586010 restaurant
    Then I should have oscar in channel
