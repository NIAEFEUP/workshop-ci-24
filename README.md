# CI/CD Workshop 2024

### The objective

Let's imagine you've recently entered a company that develops a Flutter application, CineScope (completely not my ESOF project) however they have no CI/CD processes and they would like you to implement it.

You should have:
 - A CI pipeline that runs the linter, the formatter, and finally, the unit tests. It should run on every PR but also every push to the main branch;
 - A CD pipeline that builds the final application as an APK and creates a GitHub Release for it.