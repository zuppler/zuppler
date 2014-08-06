Feature: Notification resource
  Notification resource

  @vcr
  Scenario: Execute
    Given Zuppler configured with "zuppler" and "qwe123"
    And I have an order "962635ae-d752-11e3-8584-123138166518"
    When I execute "pos" notification
    Then I should have notification accepted

  @vcr
  Scenario: Confirm
    Given Zuppler configured with "zuppler" and "qwe123"
    And I have an order "962635ae-d752-11e3-8584-123138166518"
    When I confirm "pos" notification
    Then I should have notification accepted
    
