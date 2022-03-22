<!-- ------------------------------------------------------------ -->
<!-- https://github.com/mcavallo-git/Coding/blob/master/git/github_compare-repository-changes-over-time_merge-pull-requests.md -->
<!-- ------------------------------------------------------------ -->

<hr />

# GitHub - Compare repository changes over time

1. On GitHub, create a new pull request for the repo in-question (which you wish to compare over a given time period)
2. For the FROM branch (right branch-dropdown within the pull-request):
  - Type the name of the branch in-question (or type 'master' for the trunk)
  - Append your time period's ***END*** date, wrapped in curly braces and matching format @{MM-DD-YY}, onto the right-side of the branch-name
    - Example format: `master@{MM-DD-YY}`
3. For the TO branch (left branch-dropdown within the pull-request)
  - Type the same branch as the FROM branch
  - Append your time period's ***START*** date, wrapped in curly braces and matching format @{MM-DD-YY}, onto the right-side of the branch-name
    - Example format: `master@{MM-DD-YY}`


<br /><hr />

# Example(s)
  - ```
    TO:    master@{08-01-19}
    FROM:  master
    ```


<br /><hr />

# Citation(s)
 - <a href="https://help.github.com/en/articles/comparing-commits-across-time#comparisons-across-time">Comparing commits across time</a>


<br /><hr />