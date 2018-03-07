Feature: User
  Working with test user:
  id: 14802
  name: Test Zuppler
  email test@zuppler.com
  token: see initilization_steps.rb
  application token: see initilization_steps.rb

  TODO: update token after each restore DB on staging

  Background:
    Given Zuppler configured with "zuppler" and "qwe123"
    And Zuppler user token

  @vcr
  Scenario: Show user
    Given I initialize user
    Then I have user details

  @vcr
  Scenario: Touch
    Given I initialize user
    And I touch user
    Then receive success response

  @vcr
  Scenario: User not authorized
    Given I initialize user with "notauthorized"
    Then I am not authorized

  # @vcr
  # Scenario: Update user grant without roles
  #   Given I initialize user with "af1813ae5d79a6e16e574a44c8398d6a6508b825fb31c80b8deddec302f83019"
  #   And I update access grant
  #   Then I receive not enough roles

  @vcr
  Scenario: Update user grant with user token
    Given I initialize user
    And I update access grant
    Then I receive failure grant

  @vcr
  Scenario: Update user grant with application token
    When Zuppler application token
    Given I initialize user
    When I update access grant
    Then I receive success grant

  @vcr
  Scenario: Get print params
    Given I initialize user
    And get print params
    Then receive print params

  @vcr
  Scenario: Update print params
    Given I initialize user
    And update print params
    Then receive success response

  @vcr
  Scenario: Search users with application token
    When Zuppler application token
    When I search users by role "ambassador"
    Then I receive ambassador users

  # FIXME: huge security hole, any user can get all users in Zuppler :(
  @vcr
  Scenario: Search users with user token
    When I search users by role "ambassador"
    Then I receive ambassador users

  @vcr
  Scenario: Get providers
    Given I initialize user
    When I get user providers
    Then I receive user providers

  @vcr
  Scenario: Get provider
    Given I initialize user
    When I get "zuppler" provider
    Then I receive user provider

  @vcr
  Scenario: Get vaults
    Given I initialize user
    When I get user vaults
    Then I receive user vaults

  @vcr
  Scenario: Create vault
    Given I initialize user
    When I create vaults
    Then vault is created

  @vcr
  Scenario: Reward points
    Given I initialize user
    And a current user
    And user has points and bucks
    When reward "1000" points
    Then user was rewarded "1000" points

  @vcr
  Scenario: Revoke points
    Given I initialize user
    And a current user
    And user has points and bucks
    When revoke "1000" points
    Then user was revoked "1000" points

  @vcr
  Scenario: Reward bucks
    Given I initialize user
    And a current user
    And user has points and bucks
    When reward "10" bucks for "1" restaurant
    Then user was rewarded "10" bucks for "1" restaurant

  @vcr
  Scenario: Revoke bucks
    Given I initialize user
    And a current user
    And user has points and bucks
    When revoke "1000" points for "1" restaurant
    Then user was revoked "1000" points for "1" restaurant
