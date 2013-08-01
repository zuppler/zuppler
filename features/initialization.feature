Feature: Zuppler Initialization
  In order to use Zuppler
  The client has to initialize

  Scenario: Channel and api_key
    Given Zuppler is loaded
    When I initialize with zuppler and qwe123
    Then Is initialized with zuppler and qwe123
