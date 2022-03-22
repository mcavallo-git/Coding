<!-- ------------------------------------------------------------ -->
<!-- https://github.com/mcavallo-git/Coding/blob/master/git/github_compare-repository-changes-over-time_merge-pull-requests.md -->
<!-- ------------------------------------------------------------ -->

<hr />

# GitHub - Compare repository changes over time

<hr />

- General Syntax:
  - `branch-name@{MM-DD-YY}`

<hr />

1. On GitHub, create a new PR (pull request) for the repo in question (which you wish to compare over a given time period)
2. Choose one of the following methods of comparing the differences between the current state of a branch and the state it was in on a given date:
   - ## Using `branch` in the `TO` field + `branch@{date}` in the `FROM` field
      - Type the branch name into the `TO` branch field
      - Type the same branch name into the `FROM` branch field, then append your time period's ***START*** date using format `@{MM-DD-YY}` onto the branch name using format `branch@{MM-DD-YY}`
      - Example: 
        - ```
          TO:    main
          FROM:  main@{08-01-19}
          ```
   - ## Using `branch` in the `FROM` field + `branch@{date}` in the `TO` field
      - Type the branch name into the `FROM` branch field
      - Type the same branch name into the `TO` branch field, then append your time period's ***END*** date using format `@{MM-DD-YY}` onto the branch name using format `branch@{MM-DD-YY}`
      - Example: 
        - ```
          TO:    main@{08-01-19}
          FROM:  main
          ```
3. Inspect any differences between files on the PR


<hr />

# Citation(s)
 - <a href="https://help.github.com/en/articles/comparing-commits-across-time#comparisons-across-time">Comparing commits across time</a>


<hr />