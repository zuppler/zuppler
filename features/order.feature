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
    And I have an order "e692b248-57f7-11e5-99a6-927284b3d77a"
    When I confirm order
    Then I should have order accepted

  # @vcr
  # Scenario: Cancel order
  #   Given Zuppler configured with "zuppler" and "qwe123"
  #   And I have an order "fcbe0bfe-78df-11e5-94c3-4e2ac2a314c1"
  #   When I cancel order
  #   Then I should have order accepted

  # @vcr
  # Scenario: Miss order
  #   Given Zuppler configured with "zuppler" and "qwe123"
  #   And I have an order "fcbe0bfe-78df-11e5-94c3-4e2ac2a314c1"
  #   When I miss order
  #   Then I should have order accepted

  # @vcr
  # Scenario: Open order
  #   Given Zuppler configured with "zuppler" and "qwe123"
  #   And I have an order "faf1ff3c-c0b8-11e3-8cc3-22000a98a19e"
  #   When I open order
  #   Then I get hash response

  # @vcr
  # Scenario: Close order
  #   Given Zuppler configured with "zuppler" and "qwe123"
  #   And I have an order "faf1ff3c-c0b8-11e3-8cc3-22000a98a19e"
  #   When I close order
  #   Then I get hash response

  # @vcr
  # Scenario: Touch order
  #   Given Zuppler configured with "zuppler" and "qwe123"
  #   And I have an order "fcbe0bfe-78df-11e5-94c3-4e2ac2a314c1"
  #   When I touch order
  #   Then I should have order accepted

  # @vcr
  # Scenario: Update order
  #   Given Zuppler configured with "zuppler" and "qwe123"
  #   And I have an order "faf1ff3c-c0b8-11e3-8cc3-22000a98a19e"
  #   When I update order
  #   Then I should have order accepted


