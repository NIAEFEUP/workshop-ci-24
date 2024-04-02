# CI/CD Workshop 2024

## The objective

Let's imagine you've recently entered a company that develops a Flutter application, CineScope (completly not my ESOF project) however they have no CI/CD processes and they would like that you implement it.

You should have:
 - A CI pipeline that runs the linter, the formatter and finally, runs the unit tests. It should run on every PR but also on every push to main;
 - A CD pipeline that builds the final application as an apk and creates a GitHub Release for it.