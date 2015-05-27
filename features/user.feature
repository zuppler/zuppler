Feature: User

  @vcr
  Scenario: Show user
    Given Zuppler configured with "zuppler" and "qwe123"
    When I initialize user with "7fb06228598aeb82347b5f76dbebfffc99028936cdccd95ad4970de55057e054"
    Then I should have user details

  @vcr
  Scenario: User not authorized
    Given Zuppler configured with "zuppler" and "qwe123"
    When I initialize user with "notauthorized"
    Then I am not authorized
    
