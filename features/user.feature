Feature: User

  @vcr
  Scenario: Show user
    Given Zuppler configured with "zuppler" and "qwe123"
    When I initialize user with "af1813ae5d79a6e16e574a44c8398d6a6508b825fb31c80b8deddec302f83019"
    Then I have user details

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
    Then I receive not enough roles

  @vcr
  Scenario: Update user grant
    Given Zuppler configured with "zuppler" and "qwe123"
    When I initialize user with "fc1c261b82768137b36822b380d29289d82c05c0c4b9ee9bcfab720214ae9e6e"
    And I update access grant
    Then I receive success grant

  @vcr
  Scenario: Search users with application token
    Given Zuppler configured with "zuppler" and "qwe123"
    And Zuppler application token
    When I search users by role "ambassador"
    Then I receive ambassador users

  # FIXME: huge security hole, any user can get all users in Zuppler :(
  @vcr
  Scenario: Search users with user token
    Given Zuppler configured with "zuppler" and "qwe123"
    And Zuppler user token
    When I search users by role "ambassador"
    Then I receive ambassador users

  @vcr
  Scenario: Get providers
    Given Zuppler configured with "zuppler" and "qwe123"
    When I initialize user with "e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9"
    When I get user providers
    Then I receive user providers

  @vcr
  Scenario: Get vaults
    Given Zuppler configured with "zuppler" and "qwe123"
    When I initialize user with "e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9"
    When I get user vaults
    Then I receive user vaults
