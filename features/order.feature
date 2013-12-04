Feature: Order resource
  Create/Update order

  @vcr
  Scenario: Confirm order
    Given Zuppler configured with "zuppler" and "qwe123"
    And I have an order "9ec79b04-580d-11e3-ac68-123138166518"
    When I confirm order
    Then I should have order confirmed

  @vcr
  Scenario: Reject order
    Given Zuppler configured with "zuppler" and "qwe123"
    And I have an order "9ec79b04-580d-11e3-ac68-123138166518"
    When I reject order
    Then I should have order rejected
    
