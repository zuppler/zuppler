Feature: Order resource
  Create/Update order

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
    
