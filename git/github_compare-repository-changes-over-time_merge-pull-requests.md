<!-- ------------------------------------------------------------ -->
<!-- https://github.com/mcavallo-git/Coding/blob/master/git/github_compare-repository-changes-over-time_merge-pull-requests.md -->
<!-- ------------------------------------------------------------ -->

<hr />

# GitHub - Compare repository changes over time

1. On GitHub, create a new PR (pull request) for the repo in question (which you wish to compare over a given time period)
2. Choose one of the following (2) methods of comparisons:
   - Using date syntax in the `FROM` branch field on a PR
      - Type the branch name into the `TO` branch field
      - Type the same branch name into the `FROM` branch field, then append your time period's ***START*** date using format `@{MM-DD-YY}` onto the branch name using format `branch-name@{MM-DD-YY}`
      - Example: 
        - ```
          TO:    main
          FROM:  main@{08-01-19}
          ```
   - Using date syntax in the `TO` branch field on a PR
      - Type the branch name into the `FROM` branch field
      - Type the same branch name into the `TO` branch field, then append your time period's ***END*** date using format `@{MM-DD-YY}` onto the branch name using format `branch-name@{MM-DD-YY}`
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