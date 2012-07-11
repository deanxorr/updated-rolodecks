Feature: Connection

  In order to establish a relationship with another user
  As an unconnected user of rollodecks 
  I want to establish a connection with that user

  Scenario: I connect with another contact
    Given There is a contact 'bob' I want to connect to and I am logged in
    When I go to my suggested contacts page
    And I press the connect button next to 'bob'
    Then I add 'bob' to my connections
