Feature: login of an existing user

    As an user, I should be able to create an unique account so that I can be distinguished of other users.

    Scenario: User logins correctly
        Given the user is not authenticated
        When I tap the "signinButton" button
        When I fill the "emailField" field with "teste@gmail.com"
        When I fill the "passwordField" field with "teste123"
        When I tap the "loginButton" button
        Then I pause for 5 seconds
        Then I expect to be in the main page

