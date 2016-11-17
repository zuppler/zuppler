Feature: User
  Working with test user:
  id: 14802
  name: Test Zuppler
  email test@zuppler.com
  token: e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9

  Background:
    Given Zuppler configured with "zuppler" and "qwe123"

  @vcr
  Scenario: Show user
    When I initialize user with "e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9"
    Then I have user details

  @vcr
  Scenario: User not authorized
    When I initialize user with "notauthorized"
    Then I am not authorized

  # @vcr
  # Scenario: Update user grant without roles
  #   When I initialize user with "af1813ae5d79a6e16e574a44c8398d6a6508b825fb31c80b8deddec302f83019"
  #   And I update access grant
  #   Then I receive not enough roles

  @vcr
  Scenario: Update user grant
    When I initialize user with "e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9"
    And I update access grant
    Then I receive success grant

  @vcr
  Scenario: Search users with application token
    When Zuppler application token
    When I search users by role "ambassador"
    Then I receive ambassador users

  # FIXME: huge security hole, any user can get all users in Zuppler :(
  @vcr
  Scenario: Search users with user token
    When Zuppler user token
    When I search users by role "ambassador"
    Then I receive ambassador users

  @vcr
  Scenario: Get providers
    When I initialize user with "e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9"
    When I get user providers
    Then I receive user providers

  @vcr
  Scenario: Get provider
    When I initialize user with "e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9"
    When I get "zuppler" provider
    Then I receive user provider

  @vcr
  Scenario: Get vaults
    When I initialize user with "e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9"
    When I get user vaults
    Then I receive user vaults

  @vcr
  Scenario: Create vault
    When I initialize user with "e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9"
    When I create vaults
    Then vault is created

  @vcr
  Scenario: Reward points
    Given an "e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9" user
    And user has points and bucks
    When reward "1000" points
    Then user was rewarded "1000" points

  @vcr
  Scenario: Revoke points
    Given an "e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9" user
    And user has points and bucks
    When revoke "1000" points
    Then user was revoked "1000" points

  @vcr
  Scenario: Reward bucks
    Given an "e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9" user
    And user has points and bucks
    When reward "10" bucks for "1" restaurant
    Then user was rewarded "10" bucks for "1" restaurant

  @vcr
  Scenario: Revoke bucks
    Given an "e4c22df01390e46bb2e7c9e07698e526b3674d5e24a45bc9e173a6fc3560d6c9" user
    And user has points and bucks
    When revoke "1000" points for "1" restaurant
    Then user was revoked "1000" points for "1" restaurant
