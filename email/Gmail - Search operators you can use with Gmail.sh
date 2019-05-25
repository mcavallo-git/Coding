
# ------------------------------------------------------------
#	Syntax
#
#		AND as a conditional
#

#	Use a single space so separate search-items (items CANNOT be wrapped in curly brackets - see OR conditional)
... ...

# Gmail example(s):
from:foo subject:bar



# ------------------------------------------------------------
#	Syntax
#
#		OR as a conditional
#

# Option 1 - Use command OR (must be capitalized and have at least one space on each side) to separate search-items
... OR ...

# Option 2 - Wrap search-items with {curly bracets} and use space delimitation, ideally
{... ...}


# Gmail example(s):
from:foo OR subject:bar
{from:foo subject:bar}



# ------------------------------------------------------------
#	Syntax
#
#		NOT as a conditional
#

# Option 1: Use command NOT (must be capitalized and followed by at least one space) before search-item
NOT ...

# Option 2: Place a -minus sign, followed immediately by search-item (WITHOUT a space between the "-" and the search-item)
-...

# Gmail example(s):
NOT from:foo
-subject:bar



# ------------------------------------------------------------
#	Syntax
#
#		AROUND
#

# Option 1: Use command AROUND x between search-items (replace x with the maximum words between search-items)
... AROUND x ...

# Option 2: Wrap option 1 with double-quotes (") to match order of search-item (find first search-item, followed by x max words, followed by second search-item)
"... AROUND x ..."

# Gmail example(s):
foo AROUND 50 bar
"foo AROUND 50 bar"



# ------------------------------------------------------------
#	Syntax
#
#		Phrases
#

# Wrap phrases with double-quotes (") - note that negating to use the double-quotes will also match any items containing all search-items anywhere in them (see AND conditional)
"..."

# Gmail example(s):
"G Suite"



# ------------------------------------------------------------
#	Synax
#
#		Grouping conditionals
#

# Wrap search-items with (round bracets) and use space delimitation, ideally
(... ...)


# Gmail example(s):
(from:foo subject:bar) OR (from:bar subject:foo)



# ------------------------------------------------------------
#	Syntax
#
# 	Combine multi-field searches (to+from+subject, etc.) in the "Has the words" Gmail-filter field
#			--> Useful search operators you can access from the basic dialog include:


Has the words {


	from:...								# Sender's email-address

		list:...							# Messages from a mailing list	



	to:...									# Original recipient email-address(es) in the 'to' field

		deliveredto:...				# Resolved recipient email-address(es), i.e. a single-user's email-address, which was resolved from the 'to' field containing a forwarding group

		cc:...								# Indirect recipient email-address(es)

		bcc:...								# Blind recipient email-address(es) - Outgoing only (matches items in 'Sent', only)



	subject:...							# Subject searches


	"...","..."							# Body searches (no designation before search-item, i.e. nothing such-as "to:" or "from:" before search-item)


	rfc822msgid:...					# Messages with a certain message-id header	(e.g. rfc822msgid:200503292@example.com)


	has:nouserlabels				# Messages w/ NO label


	has:userlabels					# Messages w/ a label
		label:important				# Search for messages marked "important" (same as "is:important") <-- VERIFY THIS


	is:read									# Read messages
	is:unread								# Unread messages


	is:important						# Search for messages marked "important" (same as "label:important") <-- VERIFY THIS


	is:chat									# Chat messages
	is:starred							# Starred messages
	is:snoozed							# Snoozed messages


	in:anywhere							#	Messages in any folder, including Spam and Trash
		in:spam									#	Messages in any folder, including Spam and Trash


	older_than:...					# Messages sent before a RELATIVE point in time, using "d" (day), "m" (month), and "y" (year) (e.g. older_than:2d)
		before:...							# Messages sent before an ABSOLUTE point in time (e.g. before:2004/04/16) (same as "older:...") <-- VERIFY THIS
		older:...								# Messages sent before an ABSOLUTE point in time (e.g. older:2004/04/16) (same as "before:...") <-- VERIFY THIS


	newer_than:...					# Messages sent after a RELATIVE point in time, using "d" (day), "m" (month), and "y" (year)  (e.g. newer_than:2d)
		after:...								# Messages sent after an ABSOLUTE point in time (e.g. after:2004/04/16) (same as "newer:...") <-- VERIFY THIS
		newer:...								# Messages sent after an ABSOLUTE point in time (e.g. newer:2004/04/16) (same as "after:...") <-- VERIFY THIS


	has:attachment					# Messages w/ at least one attachment
		has:drive							# Messages w/ a Google Drive attachment or link
		has:document					# Messages w/ a Google Docs attachment or link
		has:spreadsheet				# Messages w/ a Google Sheets attachment or link
		has:presentation			# Messages w/ a Google Slides attachment or link
		has:youtube						# Messages that have a YouTube video


	has:yellow-star						# Messages that include an icon (star) of a certain color (yellow)
	has:blue-info 						# Messages that include an icon (info) of a certain color (blue)


	filename:...					# Attachments with a certain name (e.g. filename:homework.txt) or file type (e.g. filename:pdf)


	size:...								# Total message filesize (header, text, attachments, etc.) is larger than a given number of bytes (e.g. size:1048575) (same as "larger_than:...")
		larger_than:...				# Total message filesize (header, text, attachments, etc.) is larger than a given number of bytes (e.g. larger_than:5242880) (same as "size:...")
		smaller_than:...			# Total message filesize (header, text, attachments, etc.) is smaller than a given number of bytes (e.g. smaller_than:1048575)


}


# ------------------------------------------------------------
#
#		Citation(s)
#
#		Conditionals - support.google.com, "Search operators you can use with Gmail", https://support.google.com/mail/answer/7190?hl=en&visit_id=1555693720048-3324173249626126035&rd=1
#
# ------------------------------------------------------------
