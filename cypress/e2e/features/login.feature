Feature: Login
Scenario: Login user with correct email and password
    Given I navigate to automation exercise website
    When I enter login credentials "example1@test.com" "foobar"
    # Then I should be logged in
    Then I should see the error message "Your email or password is incorrect!"
