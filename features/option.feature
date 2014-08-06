Feature: Option resource
  Option resource

  @vcr
  Scenario: Create option
    Given Zuppler configured with "zuppler" and "abcd"
    And I have a restaurant "1","demorestaurant"
    And I have a modifier "1"
    When I create option "cheese","desc","99","2"
    Then I should have option created

  @vcr
  Scenario: Update option
    Given Zuppler configured with "zuppler" and "abcd"
    And I have an option "1"
    When I update option with "updated","9","1","true"
    Then I should get success response

  @vcr
  Scenario: Delete option
    Given Zuppler configured with "zuppler" and "abcd"
    And I have an option "1"
    When I delete option
    Then I should get success response
