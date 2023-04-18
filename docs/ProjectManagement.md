
# Project management


# Iteration 0

## Retroscpetive

Overall, all work needed to be done in iteration 0 was achieved, but with some issues on some tasks:

"Try to be more on point. A large part of the vision statement is just adding entropy."
 - It was fixed to make the vision more clear by clearing out the clutter in the phrase

"nothing should be ambiguous "about actors, episodes, and other things.". 
user stories should be more granular "As an user, I want to share my experience about the film/series and let other users comment about my experience""
 - We fixed the ambiguitity on the user stores

"mockups should be in the description, not as comments. they should be concrete, and not use placeholder text
the user interaction should be clear - where does the user click?"
 - We understand that user interaction was not clear, and it requrires more screenshots to reflect it, and will fix on the next iterations.

"these tests are not explicit enough to be automated. "and the comment should be shared" - how do we test this?"
 - Gherkin tests will be refactored altogether by making the syntax more clear, with explicit inputs, in order to make the tests runnable. This will be fixed while implementing said user story.
 
 "while you can use the table view, we expect a column based board available with issues sorted there.
moscow e priorities not shown"
 - We have already made those changes but we forgot to save them, and now it's fixed :)

"will there be a local database schema? if not, business logic can interact with firebase directly."
 - We are expecting to have some "caching" locally and maybe we will have a small database locally, in order to see the watchlist and other features offline.

On the other side, the vertical prototype worked flawlessly, but with some problems on the flutter's implementation on material 3
that required custom widgets to solve it.


# Iteration 1

## Planning
![Planning of iteration 1](https://user-images.githubusercontent.com/24589619/225722688-095093be-3616-4793-a0c6-d78624d414ba.png)
## Final board status
![Final board status of iteration 1](https://user-images.githubusercontent.com/24589619/228909556-be70df1b-87fa-4899-a9ff-80b56e7e3b0f.png)

## Retrospective

Application:
 - Overall for the first iteration we did a good job implementing them, but we still need to improve on user experience by adding more feedback to the user, when it's doing something wrong. Also we should hide UI that doesen't do anything right now to improve it.
 - Federated login is a bit of a mess, because of google not accepting debug keystores while logging in on federated login providers.
 - IMDB JSON parsing from the pages is a bit difficult, but still better than using unofficial APIs.

Documentation:
 - We still need to improve our user stories, to make them more clear.
 - We need to alter the domain model and logical model to be actually acturate this time.
 - Fix acceptance tests, doing it each user story.
 - 
# Iteration 2

## Planning
![Planning of iteration 2](https://user-images.githubusercontent.com/24589619/228917288-76f135c5-cad8-47aa-8425-7415c11c5f8e.png)

## Final board status
![Final board status of iteration 2](https://user-images.githubusercontent.com/24589619/232922839-e12f0deb-9708-4fd3-9c3f-db852b1e7e95.png)



