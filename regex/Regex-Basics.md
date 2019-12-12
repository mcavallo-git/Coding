# Regex Basics



***	
### Essential Mindset
###### Regular expressions ('regex patterns') bring to the table a means of defining exact templates which cookie-cut their way through anything built from characters, be it user-entered input, a nine-million-line log file, or any other string, regex will attempt to parse out of it whatever your predefined pattern tells it to parse out of it. But, with power comes responsibility, and developers who know regex understand when and where it is needed. Most major programming languages contain prebuilt methods which allow developers to search/parse strings for 99% of parsing tasks, therefore regex is usually only found where it is vital for its exactness. If you're still reading this, thanks for letting me ramble on! This starts at the beginning, regex's syntax



***
### General Syntax
* Regex reads left-to-right - If a program had the string "Jack is an awesome apprentice" and tested it against the simple, one-character regex pattern ```a```, only the first "a" after the "J" in "Jack" would be matched, and the following "a" in "an", "awesome", and "apprentice" would be ignored, because we didn't explicitly tell it to look for more than just "a". This is like opening an IDE's search-tool and using the "find once" option, once, from the beginning of the string
* ```(? ... )``` The parenthesis opened with a question mark as the FIRST character can balloon into a heap full of methods which are uniquely powerful - the overarching categories these methods fall into are [ Lookarounds ], [ Non-Capturing Groups ] & [ Inline Modifiers ]. Really, just get ready to look up exactly what you see from time to time.
* ```(...)``` Without a question, the parenthesis define a group of expressions, called a 'Token'. The first character following the close-parenthesis (just after the ")") can define what requirement to apply to the Token (group), such as make them optional with a "?", make the token repeat fifteen to fifty times with a {15,50}, or more.
* ```[...]``` This is a "Character Class". It's essentially one huge 'or' statement, with each item inside of it or'ed together, and any one can fulfill a pattern match. A simple example is ```[acr]{3}```, which is read as "match character in [a,c,r] three times", and would match such strings as "car" and "arr" and "aaa". Random example, I suppose
* That's it, you're a pro. Nah the rest is so detailed I figured leave them in their exact categories. Keep reading for more.




***
### Shorthand Character Classes

* ```\d```  matches one "digit" character  -  shorthand for ```[0-9]```
* ```\D```  matches one non "digit" character  -  shorthand for ```^\d```
	
* ```\w```  matches one "word character", or ASCII character  -  shorthand for ```[A-Za-z0-9_]```
* ```\W```  matches one non "word character"  -  shorthand for ```[^\w]```
	
* ```\s```  matches one "whitespace" character   -  shorthand for ```[ \t\r\n\f]```
* ```\S```  matches one non "whitespace" character  -  shorthand for ```[^\s]```

* ```.```   refer to 'Reserved Characters' section

* Note: Perl-Style regular expressions syntax considers the following characters as 'Special' characters, which the dot wildcard will likely NOT match any character in the set ```.|*+?()[]{-\^$```  (which, with escapes, is ```\.\|\*\+\?\(\)\[\]\{\-\^\$\>\\``` )



***
### Non-Printable Characters

* ```\t```  matches tab characters (ASCII 0x09)
* ```\ ```  matches spaces

* ```\n```         matches LFs (Line Feeds) (0x0A)
* ```\r\n```       matches CRLFs (Carriage Returns) (0x0D)
* ```(?:\r)?\n```  matches LFs && CRLFs (0x0A) - Usually ```$``` should be used here, instead


* ```\a```  matches bell, 0x07 (Exotic Non-Printable Character)
* ```\e```  matches escape, 0x1B (Exotic Non-Printable Character)
* ```\f```  matches form feed, 0x0C (Exotic Non-Printable Character)
* ```\v```  matches vertical tab, 0x0B (Exotic Non-Printable Character)

* ```\uFFFF```    matches unicode characters (if your application supports unicode) (1/2)
* ```\x{FFFF}```  matches unicode characters (if your application supports unicode) (2/2)

* ```\u20AC```    matches the euro currency sign (if your application supports unicode) (1/2)
* ```\x{20AC}```  matches the euro currency sign (if your application supports unicode) (2/2)

* ```\xFF```  matches a specific character by its hexadecimal index in the character set (if your application does not support Unicode)
* ```\xA9```  matches the copyright symbol in the Latin-1 character set



***
### Anchors
###### Anchors do not match any characters/etc., but rather are used as landmarks in regex. These allow you to write expressions such as "match LINES in this string which start with 'foobar'", or "match WORDS in this string which end in 'bar'"
###### Note: JavaScript and XPath treat CRLF pairs as two line breaks
###### Note: Neither ^ nor $ match [ in-the-middle-of a CRLF pair ]

* ```\b```  landmark for a word boundary, which is the position [ after a "word" character" ] and [ before a non "word" character ]
					Note: \b also matches at the start and/or end of the string if the first and/or last characters in the string are word characters
* ```\B```  landmark for a non-word boundary, which is [ the position between two word-characters ] or [ the position between two non-word-characters ] - Essentially, \B matches at every position where \b cannot match

* ```^```   landmark for "the start of a line", which is the position [ in-the-middle-of-and-after ] every CRLF
* ```$```   landmark for "the end of a line", which is the position [ before-and-in-the-middle-of ] every CRLF

* ```\A```  landmark for "the start of the ENTIRE input-string (including newlines/line-breaks/CRLFs)". Not supported in JavaScript, POSIX, XML, and XPath.
* ```\Z```  landmark for "the end of the ENTIRE input-string (including newlines/line-breaks/CRLFs)". Not supported in JavaScript, POSIX, XML, and XPath.



***
### Tokens
###### A Regex "Token" is a single 'target', such as a single character, a group of characters, or even a group of expressions, depending on the methods used

* ```()```    Define a new "Token"  -  Allows combining of multiple expressions/characters into one statement, which may be acted on by regex methods such as "+" and "?". Returned as a "Capture Group" in the output(s) from the regex match

* ```(?:)```  Non-Capture Subpattern  -  Syntax (?:RegexHere)  -  Excludes token from returned capture groups, i.e. whatever is matched within the given (?:) expression, even though it's enclosed by (), it won't appear in the list of matches (capture groups) returned

* ```?```     Preceding Token is 'Optional'. Note: The question mark is a 'greedy' metacharacter because its FIRST execution looks for matches WITH the token, then falls back to matched WITHOUT the token - Action 1/2: Try to Match the requiring the Preceding Token, exactly 1 time. Action 2/2: If [Action 1] failed to find a match, try to Match without requiring the Preceding Token.  -  Ex:   colou?r matches "colour" or "color"

* ```+```     Match the Preceding Token one-or-more times  -  Ex:   ```A+```  matches one-or-more "A" characters, i.e. [ "A", "AA", "AAA", ... ]

* ```*```     Match the Preceding Token 0-or-more times  -  possibly shorthand for ```?+```  -  Ex:   ```A*```  matches 0-or-more "A" characters, i.e. [ "", "A", "AA", "AAA", ... ]

* ```{X}```   Match the Preceding Token (exactly) "X" times  -  Ex:   ```[1-9][0-9]{3}```    -  matches a number between 1000 and 9999


* ```{X,Y}``` Match the Preceding Token at-least "X" times and at-most "Y" times  -  Ex:    ```[1-9][0-9]{2,4}```  -  matches a number greater-than-or-equal-to 100 99999




***
### Character Classes (or 'Character Sets')
* ```[xyz]```   Character Class - Matches any single character in a given set  -  Ex:   ```[a-zA-Z0-9]``` is equivalent to ```[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWZYZ0123456789]```
* ```[^xyz]```  Negated Character Class - Matches any single character NOT a given set   -   Ex:   ```[^xyz]```   matches anything other than characters "x", "y", or "z"



***
### Metacharacters (e.g. 'Reserved Characters')
###### These following are special characters, or "metacharacters", in regex. If a regular expression is to search for any of the search-criteria, they must be escaped (by preceding them with a single backslash). Most of them are errors when used alone
* ```\.\|\*\+\?\(\)\[\]\{\-\^\$\>\\``` ALL special characters (in a copy-able string)
* ```\```  the backslash \
* ```^```  the caret ^
* ```$```  the dollar sign $
* ```.```  the period or dot .   (wildcard character, i.e. match 'any single character')
* ```|```  the vertical bar or pipe symbol |   (match preceding token 'or' following token. Ex: [ cat|dog food ] matches the strings "cat food" and "dog food")
* ```?```  the question mark ?   (Preceding Token is 'optional')
* ```*```  the asterisk or star *   ( match the Preceding Token '0-or-more times')
* ```+```  Match the Preceding Token one-or-more times
* ```(```  the opening parenthesis (
* ```)```  the closing parenthesis ) 
* ```[```  the opening square bracket [
* ```{```  the opening curly brace {
###### If you want to use any of these characters as a literal in a regex, you need to escape them with a backslash - i.e. ```1+1=2``` matches one-or-more "1" followed by "1=2", and ```1\+1=2``` matches "1+1=2"



***
### Character Escaping (esp. Metacharacters)
* Escaping in Regex is done by prepending a backslash ```\``` before a given character
* In Perl-Style regular expressions (very common regex engine), certain metacharacters may or may-not be required depending on whether the current position in the regex falls within the bounds of a character class or not
* The following scenarios require that their corresponding metacharacters be escaped
* Outside character classes:   .^$|*+?()[{\
* Inside character classes:    ]^-\




***
### Lookaround

* ```?=```		Lookahead   (or "Positive Lookahead", subcategory of "LookArounds")  -  Syntax:  (?=RegexHere)
* ```?!```		Negative Lookahead   (subcategory of "LookArounds")  -  Syntax:  (?!RegexHere)
								Positive Lookaheads assert that what immediately follows the current position in the string is "RegexHere"
								Negative Lookaheads assert that what immediately follows the current position in the string is NOT "RegexHere"
									Ex:   ```q(?=u)```   -   matches a "q" followed by a "u"
									Ex:   ```q(?!u)```   -   matches a "q" NOT followed by a "u"
									Ex:   ```^((?!foobar).)*$``` Match all lines which do NOT have the word 'foobar' anywhere in them
									Ex:   ```^(?!ignoreme|ignoreme2)([a-z0-9]+)$```  -  matches "hello" and "hello123", but skips "ignoreme" and "ignoreme2"

* ```?<=```		Lookbehind   (or "Positive Lookbehind", subcategory of "LookArounds")  -  Syntax:  (?<=RegexHere)
* ```?<!```		Negative Lookbehind   (subcategory of "LookArounds")  -  Syntax:  (?<!RegexHere)
								Positive Lookbehinds assert that what immediately precedes the current position in the string is "RegexHere"
								Negative Lookbehinds assert that what immediately precedes the current position in the string is NOT "RegexHere"
									Ex: (?<=q)u   -   matches a "u" preceded by a "q"
									Ex: (?<!q)u   -   matches a "u" NOT preceded by a "q"
									Ex: (?<!host)\.com   -   matches ".com" NOT preceded by "host"
								NOTE: Javascript only supports Negative-Lookbehinds in the latest version of Chrome (as-of 2019-08-01)
									|--> As a workaround, Negative Lookbehinds can be rebuilt as a negative lookahead (which is commonly supported in Javascript) as follows:
									Ex: ((?!q).|^)u   -   matches a "u" NOT preceded by a "q"        [-Citation_01-]




***
### Capture Groups
###### Capture Groups set many special global variables
###### Use these variables to format the output of your expression the way you want. i.e. Use them to control the returned value(s) from a given expression-match function
* ```$n```  The [ nth ] Capture Group's returned value.
					Note: If no match was found (or if given group doesn't exist in expression), value is equal to a blank string, i.e. "";
								Ex: $1  -  The [ 1st ] Capture Group's returned match
								Ex: $2  -  The [ 2nd ] Capture Group's returned match
* ```$~```  is equivalent to ::last_match
* ```$&```  'lastMatch' property (static). JS:  "RegExp.lastMatch" or "RegExp['$&']"   contains the complete matched text
* ```$````  contains string before match
* ```$'```  contains string after match
* ```$+```  contains last Capture Groups



***
### Javascript-Specific Regex
* ```/g```     'Global' (apply action to all matches, not just the first match)
* ```/i```     'Case Insensitive' (case-sensitivity is enabled by-default in regex)
* ```/m```     'Case Insensitive' (/m enables "multi-line mode". In this mode, the caret and dollar match before and after newlines in the subject string.
* ```\XYZ\```  Hardcode a regex formula (XYZ in this example) as a string-literal - Note: If you have a variable string, use ``` var dat_string="XYZ"; var regex_test = new RegExp(dat_string);```



***
### Inline Modifiers
###### Normally, matching modes are specified outside the regular expression. In a programming language, you pass them as a flag to the regex constructor or append them to the regex literal - In an application, you'd toggle the appropriate buttons or checkboxes.

* ```(?i)```  makes the regex case insensitive.
* ```(?c)```  makes the regex case sensitive. Only supported by Tcl.
* ```(?x)```  turn on free-spacing mode.
* ```(?t)```  turn off free-spacing mode. Only supported by Tcl.
* ```(?xx)``` turn on free-spacing mode, also in character classes. Supported by Perl 5.26 and PCRE2 10.30.
* ```(?s)```  for "single line mode" makes the dot match all characters, including line breaks. Not supported by Ruby or JavaScript. In Tcl, (?s) also makes the caret and dollar match at the start and end of the string only.
* ```(?m)```  for "multi-line mode" makes the caret and dollar match at the start and end of each line in the subject string. In Ruby, (?m) makes the dot match all characters, without affecting the caret and dollar which always match at the start and end of each line in Ruby. In Tcl, (?m) also prevents the dot from matching line breaks.
* ```(?p)```  in Tcl makes the caret and dollar match at the start and the end of each line, and makes the dot match line breaks.
* ```(?w)```  in Tcl makes the caret and dollar match only at the start and the end of the subject string, and prevents the dot from matching line breaks.
* ```(?n)```  turns all unnamed groups into non-capturing groups. Only supported by .NET, XRegExp, and the JGsoft flavor. In Tcl, (?n) is the same as (?m).
* ```(?J)```  allows duplicate group names. Only supported by PCRE and languages that use it such as Delphi, PHP and R.
* ```(?U)```  turns on "ungreedy mode", which switches the syntax for greedy and lazy quantifiers. So (?U)a* is lazy and (?U)a*? is greedy. Only supported by PCRE and languages that use it. It's use is strongly discouraged because it confuses the meaning of the standard quantifier syntax.
* ```(?d)``` corresponds with UNIX_LINES in Java, which makes the dot, caret, and dollar treat only the newline character \n as a line break, instead of recognizing all line break  characters from the Unicode standard. Whether they match or don't match (at) line breaks depends on (?s) and (?m).
* ```(?b)```  makes Tcl interpret the regex as a POSIX BRE.
* ```(?e)```  makes Tcl interpret the regex as a POSIX ERE.
* ```(?q)```  makes Tcl interpret the regex as a literal string (minus the (?q) characters).
* ```(?X)```  makes escaping letters with a backslash an error if that combination is not a valid regex token. Only supported by PCRE and languages that use it.



***
### Modifying Output (upper-casing, lower-casing, etc.)
###### Thanks to StackOverflow user [ Armfoot ] on forum [ https://stackoverflow.com/questions/20742076 ]

* Capitalize words (note that \s also matches new lines, i.e. "venuS" => "VenuS")
Find: ```(\s)([a-z])```
Replacement: ```$1\u$2```

* Remove-Capitalization from words
Find: ```(\s)([A-Z])```
Replacement: ```$1\l$2```

* Remove Camel-Case (e.g. cAmelCAse => camelcAse => camelcase)
Find: ```([a-z])([A-Z])```
Replacement: ```$1\l$2```

* Lowercase letters within words (e.g. LowerCASe => Lowercase)
Find: ```(\w)([A-Z]+)```
Replacement: ```$1\L$2```
Alternate Replacement: ```\L$0```

* Uppercase letters within words (e.g. upperCASe => uPPERCASE)
Find: ```(\w)([A-Z]+)```
Replacement: ```$1\U$2```

* Uppercase previous (e.g. upperCase => UPPERCase)
Find: ```(\w+)([A-Z])```
Replacement: ```\U$1$2```

* Lowercase previous (e.g. LOWERCase => lowerCase)
Find: ```(\w+)([A-Z])```
Replacement: ```\L$1$2```

* Uppercase the rest (e.g. upperCase => upperCASE)
Find: ```([A-Z])(\w+)```
Replacement: ```$1\U$2```

* Lowercase the rest (e.g. lOWERCASE => lOwercase)
Find: ```([A-Z])(\w+)```
Replacement: ```$1\L$2```

* Shift-right-uppercase (e.g. Case => cAse => caSe => casE)
Find: ```([a-z\s])([A-Z])(\w)```
Replacement: ```$1\l$2\u$3```

* Shift-left-uppercase (e.g. CasE => CaSe => CAse => Case)
Find: ```(\w)([A-Z])([a-z\s])```
Replacement: ```\u$1\l$2$3```



***
### Assorted Use-Cases

###### Match an HTML tag without any attributes
* ```<[A-Za-z][A-Za-z0-9]*>``` or ```<[A-Za-z0-9]+>```

###### Match lines [ starting with "@@" ], followed by [ 1 to 100 word-characters], followed by [ one space character ], NOT followed by [ one space character ]  -  Used while searching MySQL exports for specific variable settings
* ```^(@@[0-9a-zA-Z\_]{1,100})(\ )+(!?\ ){1}```

###### Match any line ...
######  |--> EXCLUDING lines whose text-content starts with "git-" or "git[a-z]" by using:  (?!git[a-z\-])
######  |--> INCLUDING lines with any amount of indentation before their text-content by using:  (?:\s*)
######  |--> INCLUDING any blank-lines by wrapping the statement as follows: (...)?
######  |--> INCLUDING lines with fewer than 4 characters (length of excluded string "git-") by using:with few characters by using: (?:(?:(?:.\s?){0,3})|(?:(?:\S\s?){1,4}.*))
* ```^((?:\s*)(?!git[a-z\-])(?:(?:(?:.\s?){0,3})|(?:(?:\S\s?){1,4}.*)))?$```



***
### Citation(s)

###### * Quickstart Tutorial, https://www.regular-expressions.info/quickstart.html

###### * LookArounds, https://www.rexegg.com/regex-lookarounds.html

###### * LookArounds, https://www.regular-expressions.info/lookaround.html

###### * Non-Capture Subpatterns, https://stackoverflow.com/questions/3705842/what-does-do-in-regex

###### * Capture Groups, https://ruby-doc.org/core-2.1.1/Regexp.html

###### * Modifying Output (upper-casing, lower-casing, etc.), https://stackoverflow.com/questions/20742076

###### * [-Citation_01-] stackoverflow.com  | "Javascript: negative lookbehind equivalent?"  |  https://stackoverflow.com/a/27213663