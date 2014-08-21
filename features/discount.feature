Feature: Discount resource
  Discount resource

  @vcr
  Scenario: Create discount
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    When I create discount "savings","15","99","abcd"
    Then I should have discount created

  @vcr
  Scenario: Update discount
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a discount "904"
    When I update discount "updated","25","50"
    Then I should get success response

  # @vcr
  # Scenario: Delete discount
  #   Given Zuppler configured with "zuppler" and "abcd"
  #   And I have a discount "1"
  #   When I delete discount
  #   Then I should get success response
