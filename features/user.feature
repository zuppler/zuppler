Feature: User

  @vcr
  Scenario: Show user
    Given Zuppler configured with "zuppler" and "qwe123"
    When I initialize user with "af1813ae5d79a6e16e574a44c8398d6a6508b825fb31c80b8deddec302f83019"
    Then I should have user details

  @vcr
  Scenario: User not authorized
    Given Zuppler configured with "zuppler" and "qwe123"
    When I initialize user with "notauthorized"
    Then I am not authorized

  @vcr
  Scenario: Update user grant without roles
    Given Zuppler configured with "zuppler" and "qwe123"
    When I initialize user with "af1813ae5d79a6e16e574a44c8398d6a6508b825fb31c80b8deddec302f83019"
    And I update access grant
    Then I should receive not enough roles

  @vcr
  Scenario: Update user grant
    Given Zuppler configured with "zuppler" and "qwe123"
    When I initialize user with "fc1c261b82768137b36822b380d29289d82c05c0c4b9ee9bcfab720214ae9e6e"
    And I update access grant
    Then I should receive success grant
