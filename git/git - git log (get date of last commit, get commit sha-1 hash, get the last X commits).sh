#!/bin/bash
# ------------------------------

git log --oneline --max-count 10;  # Get the latest 10 commits for the current branch


git log --max-count=30 --format="%H | %ad | %s | %b" --date=format:'%Y-%m-%dT%H:%M:%S%z';  # Get the latest 30 commits w/ full commit hash & timetamp shown for each


# ------------------------------


CHECKOUT_BRANCH="$(if [ "$(git rev-parse --abbrev-ref HEAD;)" != "HEAD" ]; then git rev-parse --abbrev-ref HEAD; else git symbolic-ref --short HEAD; fi;)"; \
echo -e "CHECKOUT_BRANCH = [\n${CHECKOUT_BRANCH}\n]";


COMMIT_HASH="$(git rev-parse HEAD;)"; \
echo -e "COMMIT_HASH = [\n${COMMIT_HASH}\n]";


LATEST_COMMIT_TIMESTAMP_RFC3339="$(git log -1 --format="%ad" --date=format:'%Y-%m-%dT%H:%M:%S%z';)"; \
echo -e "LATEST_COMMIT_TIMESTAMP_RFC3339 = [ ${LATEST_COMMIT_TIMESTAMP_RFC3339} ]";  # <# BEST FOR LOG OUTPUTS #>


LATEST_COMMIT_TIMESTAMP_FILENAME="$(git log -1 --format="%ad" --date=format::'%Y%m%dT%H%M%S%z';)"; \
echo -e "LATEST_COMMIT_TIMESTAMP_FILENAME = [ ${LATEST_COMMIT_TIMESTAMP_FILENAME} ]";  # <# BEST FOR FILENAMES #>


RFC3339_SHORT_HASHES="$(git log --max-count=30 --format="%h | %ad | %s%n" --date=format:'%Y-%m-%dT%H:%M:%S%z';)"; \
echo -e "RFC3339_SHORT_HASHES = [\n${RFC3339_SHORT_HASHES}\n]";


RFC3339_LONG_HASHES="$(git log --max-count=30 --format="%H | %ad | %s%n" --date=format:'%Y-%m-%dT%H:%M:%S%z';)"; \
echo -e "RFC3339_LONG_HASHES = [\n${RFC3339_LONG_HASHES}\n]";


# ------------------------------
#
# --date=format:"..." placeholders (git log):
#
#           ·   %a      Abbreviated weekday name
#           ·   %A      Full weekday name
#           ·   %b      Abbreviated month name
#           ·   %B      Full month name
#           ·   %c      Date and time representation appropriate for locale
#           ·   %d      Day of month as decimal number (01 – 31)
#           ·   %H      Hour in 24-hour format (00 – 23)
#           ·   %I      Hour in 12-hour format (01 – 12)
#           ·   %j      Day of year as decimal number (001 – 366)
#           ·   %m      Month as decimal number (01 – 12)
#           ·   %M      Minute as decimal number (00 – 59)
#           ·   %p      Current locale's A.M./P.M. indicator for 12-hour clock
#           ·   %S      Second as decimal number (00 – 59)
#           ·   %U      Week of year as decimal number, with Sunday as first day of week (00 – 53)
#           ·   %w      Weekday as decimal number (0 – 6; Sunday is 0)
#           ·   %W      Week of year as decimal number, with Monday as first day of week (00 – 53)
#           ·   %x      Date representation for current locale
#           ·   %X      Time representation for current locale
#           ·   %y      Year without century, as decimal number (00 – 99)
#           ·   %Y      Year with century, as decimal number
#           ·   %z, %Z  Either the time-zone name or time zone abbreviation, depending on registry settings
#           ·   %%      Percent sign
#
#
# ------------------------------
#
# --format="..." placeholders (git log):
#
#           ·   %H: commit hash 
#           ·   %h: abbreviated commit hash 
#           ·   %T: tree hash 
#           ·   %t: abbreviated tree hash 
#           ·   %P: parent hashes 
#           ·   %p: abbreviated parent hashes 
#           ·   %an: author name 
#           ·   %aN: author name (respecting .mailmap, see git-shortlog(1) or git-blame(1)) 
#           ·   %ae: author email 
#           ·   %aE: author email (respecting .mailmap, see git-shortlog(1) or git-blame(1)) 
#           ·   %ad: author date (format respects --date= option) 
#           ·   %aD: author date, RFC2822 style 
#           ·   %ar: author date, relative 
#           ·   %at: author date, UNIX timestamp 
#           ·   %ai: author date, ISO 8601-like format 
#           ·   %aI: author date, strict ISO 8601 format 
#           ·   %cn: committer name 
#           ·   %cN: committer name (respecting .mailmap, see git-shortlog(1) or git-blame(1)) 
#           ·   %ce: committer email 
#           ·   %cE: committer email (respecting .mailmap, see git-shortlog(1) or git-blame(1)) 
#           ·   %cd: committer date (format respects --date= option) 
#           ·   %cD: committer date, RFC2822 style 
#           ·   %cr: committer date, relative 
#           ·   %ct: committer date, UNIX timestamp 
#           ·   %ci: committer date, ISO 8601-like format 
#           ·   %cI: committer date, strict ISO 8601 format 
#           ·   %d: ref names, like the --decorate option of git-log(1) 
#           ·   %D: ref names without the " (", ")" wrapping. 
#           ·   %e: encoding 
#           ·   %s: subject 
#           ·   %f: sanitized subject line, suitable for a filename 
#           ·   %b: body 
#           ·   %B: raw body (unwrapped subject and body) 
#           ·   %N: commit notes 
#           ·   %GG: raw verification message from GPG for a signed commit 
#           ·   %G?: show "G" for a good (valid) signature, "B" for a bad signature, "U" for a good signature with unknown validity, "X" for a good signature that has expired, "Y" for a good signature made by an expired key, "R" for a good signature made by a revoked key, "E" if the signature cannot be checked (e.g. missing key) and "N" for no signature 
#           ·   %GS: show the name of the signer for a signed commit 
#           ·   %GK: show the key used to sign a signed commit 
#           ·   %gD: reflog selector, e.g., refs/stash@{1} or refs/stash@{2 minutes ago}; the format follows the rules described for the -g option. The portion before the @ is the refname as given on the command line (so git log -g refs/heads/master would yield refs/heads/master@{0}). 
#           ·   %gd: shortened reflog selector; same as %gD, but the refname portion is shortened for human readability (so refs/heads/master becomes just master). 
#           ·   %gn: reflog identity name 
#           ·   %gN: reflog identity name (respecting .mailmap, see git-shortlog(1) or git-blame(1)) 
#           ·   %ge: reflog identity email 
#           ·   %gE: reflog identity email (respecting .mailmap, see git-shortlog(1) or git-blame(1)) 
#           ·   %gs: reflog subject 
#           ·   %Cred: switch color to red 
#           ·   %Cgreen: switch color to green 
#           ·   %Cblue: switch color to blue 
#           ·   %Creset: reset color 
#           ·   %C(...): color specification, as described under Values in the "CONFIGURATION FILE" section of git- config(1). By default, colors are shown only when enabled for log output (by color.diff, color.ui, or --color, and respecting the auto settings of the former if we are going to a terminal). %C(auto,...)  is accepted as a historical synonym for the default (e.g., %C(auto,red)). Specifying %C(always,...) will show the colors even when color is not otherwise enabled (though consider just using `--color=always to enable color for the whole output, including this format and anything else git might color).  auto alone (i.e.  %C(auto)) will turn on auto coloring on the next placeholders until the color is switched again. 
#           ·   %m: left (<), right (>) or boundary (-) mark 
#           ·   %n: newline 
#           ·   %%: a raw % 
#           ·   %x00: print a byte from a hex code 
#           ·   %w([<w>[,<i1>[,<i2>]]]): switch line wrapping, like the -w option of git-shortlog(1). 
#           ·   %<(<N>[,trunc|ltrunc|mtrunc]): make the next placeholder take at least N columns, padding spaces on the right if necessary. Optionally truncate at the beginning (ltrunc), the middle (mtrunc) or the end (trunc) if the output is longer than N columns. Note that truncating only works correctly with N >= 2. 
#           ·   %<|(<N>): make the next placeholder take at least until Nth columns, padding spaces on the right if necessary 
#           ·   %>(<N>), %>|(<N>): similar to %<(<N>), %<|(<N>) respectively, but padding spaces on the left 
#           ·   %>>(<N>), %>>|(<N>): similar to %>(<N>), %>|(<N>) respectively, except that if the next placeholder takes more spaces than given and there are spaces on its left, use those spaces 
#           ·   %><(<N>), %><|(<N>): similar to %<(<N>), %<|(<N>) respectively, but padding both sides (i.e. the text is centered) 
#           ·   %(trailers[:options]): display the trailers of the body as interpreted by git-interpret- trailers(1). The trailers string may be followed by a colon and zero or more comma-separated options. If the only option is given, omit non-trailer lines from the trailer block. If the unfold option is given, behave as if interpret-trailer’s --unfold option was given. E.g., %(trailers:only,unfold) to do both.
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   git-scm.com  |  "Git - git-log Documentation"  |  https://git-scm.com/docs/git-log
#
#   stackoverflow.com  |  "command line - How to change Git log date formats - Stack Overflow"  |  https://stackoverflow.com/a/34778736
#
# ------------------------------------------------------------