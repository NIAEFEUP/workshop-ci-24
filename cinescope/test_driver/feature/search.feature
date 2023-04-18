Feature:  film/series searching

    As a user, I want to search for a film/series to find information about it.

    Scenario: Search for a film/series by title
        Given the user is authenticated
        Given the user is on the search page
        When the user enters "titanic" in the search bar
        Then it should be displayed a list of film/series cards that match the search criteria
        And each film/series should display its title, type, year and a small image.
