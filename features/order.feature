Feature: Order resource
  Create/Update order

  @vcr
  Scenario: Show order
    Given Zuppler configured with "zuppler" and "qwe123"
    And I have an order "793c50d8-c0bc-11e3-8cc3-22000a98a19e"
    When I fetch order details
    Then I should have order details

  @vcr
  Scenario: Confirm order
    Given Zuppler configured with "zuppler" and "qwe123"
    And I have an order "56b19cde-ac68-11e3-9088-123138166518"
    When I confirm order
    Then I should have order accepted

  @vcr
  Scenario: Cancel order
    Given Zuppler configured with "zuppler" and "qwe123"
    And I have an order "56b19cde-ac68-11e3-9088-123138166518"
    When I cancel order
    Then I should have order accepted

  @vcr
  Scenario: Miss order
    Given Zuppler configured with "zuppler" and "qwe123"
    And I have an order "56b19cde-ac68-11e3-9088-123138166518"
    When I miss order
    Then I should have order accepted
    
  @vcr
  Scenario: Notify
    Given Zuppler configured with "zuppler" and "qwe123"
    And I have an order "962635ae-d752-11e3-8584-123138166518"
    When I execute "pos" notification
    Then I should have order accepted
    
