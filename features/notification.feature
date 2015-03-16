Feature: Notification resource
  Notification resource

  @vcr
  Scenario: Execute
    Given Zuppler configured with "zuppler" and "qwe123"
    And I have an order "4d81ba6c-9507-11e4-a48a-22000b5d9596"
    When I execute "pos" notification
    Then I should have notification accepted

  @vcr
  Scenario: Confirm
    Given Zuppler configured with "zuppler" and "qwe123"
    And I have an order "4d81ba6c-9507-11e4-a48a-22000b5d9596"
    When I confirm "pos" notification
    Then I should have notification accepted
    
