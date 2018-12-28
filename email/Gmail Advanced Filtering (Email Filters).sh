
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------- #
#
#				Personal Acct
#

	Matches:		"___Starred_Items___" OR filename:("ics")
			  Do this: Star it

	Matches:		"___Mark_as_Read___" OR (subject:("Your Online Banking Alert Settings Changed"))
			  Do this: Mark as read
	
	Matches:		"___SmartHome___" OR (from:("*@wink.com"|"*@ecobee.com"|"*@smartthings.com") AND subject:("hub firmware update"|"has not been detected"|"has reconnected"|"Reminder"))
			  Do this: Skip Inbox, Apply label "Smarthome"
	
	Matches:		"___Orders_by_Subject___" OR (subject:("order"|"ship"|"package"|"payment"|"purchase") AND subject:("authorized"|"confirmation"|"notification"|"receipt"|"received")) OR "your receipt"
			  Do this: Skip Inbox, Apply label "Orders"

	Matches:		"___Orders_by_Sender___" OR from:("webbillpay"|"Citizens One"|"Wells Fargo"|"*@paypal.com"|"*@etsy.com"|"*@notify.wellsfargo.com"|"*@amazon.com"|"*@newegg.com"|"ts-noreply@google.com"|"*@em.kirklands.com"|"*@polarbearcoolers.com"|"*@prepobsessed.com"|"*@crownclub.regmovies.com"|"*@homedepot.com")
			  Do this: Skip Inbox, Apply label "Orders"

	Matches:		"___University___" OR from:("*@*.uky.edu" OR *@uky.edu)
			  Do this: Skip Inbox, Apply label "Filters/Unviersity"
				
	Matches:		"___Spam_Blocker___" OR ("unsubscribe" -{"receipt" OR "inactive numbers can expire"}) OR (from:("Valvoline"|"*@pandora.com"|"*@spotify.com"|"*@*.express.com"|"*@wish.com"|"American Home Shield"|"Asana") OR subject:("your iCloud storage") AND -"your receipt") OR (subject:("change"|"changes"|"changing"|"update"|"updates"|"updating") AND subject:("terms"))
			  Do this: Skip Inbox, Mark as read, Apply label "Filters/Spam_Blocker"
				

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------- #
#
#				Work Acct
#

	Matches:		"___Starred_Items___" OR (filename:("ics"))
			  Do this: Star it
				
	Matches:		"___Logs_PHP___" OR (from:("boneal@www.boneal.net"|"boneal@mdev.boneal.net"|"boneal@dev.boneal.net"|"boneal@rdev.boneal.net") AND (subject:("PHP error_log message")))
			  Do this: Apply label "Logs/Logs-PHP", Never send it to Spam

	Matches:		"___Logs_BNet___" OR (from:("boneal@boneal.com"|"boneal.net@boneal.com"|"boneal@www.boneal.net") AND (subject:("WMS Error Log"|"PO Total Verification"|"Backlogs & Late Sales Orders for"|"EMAIL VALIDATION ISSUES"|"upd_mas_pos.php?t="|"upd_mas_consign.php"|"Shipments for"|"No Signature on PO"|"characters in trimToFitMas():"|"Unknown column 'name_pref' in 'field list'"|"Unable to connect to server eft.tempursealy.com"|"MAS/Boneal.net Vendor and Customer Issues") OR ("Unable to Initialize the connection"))
			  Do this: Skip Inbox, Apply label "Logs/Logs-BNet"
	
	Matches:		"___Logs_Sage___" OR (from:("masreader@mail.com"|"boneal@boneal.com"|"boneal.net@boneal.com") AND subject:("MAS PO Import"|"Receipt of Goods Import Issues"|"Vendor Open POs Log"|"MAS to Boneal.net Quick Update Log"|"MAS to Boneal.net Shipment Update Log"|"Shipping/Packing List issues"|"Shipment Import Issues"|"Shipments for"))
			  Do this: Skip Inbox, Apply label "Logs/Logs-Sage", Never send it to Spam
				
	Matches:		"___Logs_Enhancements___" OR (from:("boneal.net@boneal.com") AND (subject:("Task-System Updates") OR ("Your Boneal Net Task has"|"This task has been assigned to"|"approve or reject this task"|"Task Status Complete") OR ("Boneal.Net Bugs & Requests")))
				Do this: Skip Inbox, Apply label "Logs/Logs-Enhancements", Never send it to Spam
				
	Matches:		"___AWS___" OR (from:("Amazon Web Services") AND to:("programmers@boneal.com"))
			  Do this: Skip Inbox, Apply label "_AWS"
				
	Matches:		"___Sonicwall_to_IT___" OR (from:"*@sonicwall.com")
			  Do this: Forward to klamb@boneal.com
				
	Matches:		"___Invoices_Receipts___" OR (from:(*amazon*) AND to:(programmers@boneal.com) AND subject:("Amazon Web Services Invoice Available"|"Payment Receipt for bonealnet"))
			  Do this: Skip Inbox, Apply label "Filters/Invoices"
	
	Matches:		"___Spam_Blocker___" OR ("unsubscribe" AND -(from:"*@boneal.com") AND -("receipt"|"inactive numbers can expire")) OR from:("*@*.ap-south-1.compute.internal"|"*@parts-badger.com"|"root@mail.boneal.me")
			  Do this: Skip Inbox, Mark as read, Apply label "Filters/Spam_Blocker"



#--------------------------------------------------------------------------------------------------------------------------------------------------------------------- #
#
#				Spam Acct

	Matches: 		"___Starred_Items___" OR (from:("*@noip.com") AND subject:("confirm your hostname") OR from:("notifications@p.pinger.com")
				Do this: Star it

	Matches:		"___Forward_to_Main___" OR from:("*@homedepot.com")
			  Do this: Skip Inbox, Mark as read, Forward to [main account]
			
	Matches:		"___Spam_Blocker___" OR ("unsubscribe" -{"receipt"|"inactive numbers can expire"}) OR (from:("bing@e.microsoft.com"|"*@dropboxmail.com"|"*@pandora.com"|"*@spotify.com"|"*@e.express.com"|"xboxliverewards@e.helloworldmail.com") OR subject:("Your iCloud storage is almost full.") OR "Updates to our Terms of Service and Privacy Policy")
			  Do this: Skip Inbox, Mark as read, Apply label "Filters/Spam_Blocker"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------- #
#
#				Notes

# !!! COMBINE BIG FILTER SEARCHES ALL-TOGETHER IN THE "Has the words" FIELD
#       --> Useful search operators you can access from the basic dialog include:

Has the words {

		to:("...","...") – Search for messages sent to a specific address

		from:("...","...") – Search for messages sent from a specific address

		subject:("...","...") – Search the subject field
		
		"...","..." - Body field-searches occur without a designation before (without a "[field_name]:" tag)

		label:("...","...") – Search within a specific label

		has:attachment – Search only for messages that have attachments

		is:chat – Search only chats.
		
		in:anywhere – Also search for messages in the spam and trash. By default, Gmail’s search ignores messages in the spam and trash

}

#  Constructing Searches
#   --> To put together more complicated searches, you’ll need to know the basics.

( ) # Brackets allow you to group search terms. For example, searching for subject:(how geek) would only return messages with the words “how” and “geek” in their subject field. If you search for subject:how geek, you’d get messages with “how” in their subject and “geek” anywhere in the message.

OR  # OR, which must be in capital letters, allows you to search for one term or another. For example, subject:(how OR geek) would return messages with the word “how” or the word “geek” in their titles. You can also combine other terms with the OR. For example, from:howtogeek.com OR has:attachment would search for messages that are either from howtogeek.com or have attachments.

" " # Quotes allow you to search for an exact phrase, just like in Google. Searching for "exact phrase" only returns messages that contain the exact phrase. You can combine this with other operators. For example, subject:”exact phrase” only returns messages that have “exact phrase” in their subject field.

 -  # The hyphen, or minus sign, allows to search for messages that don’t contain a specific term. For example, search for -from:howtogeek.com and you’ll only see messages that aren’t from howtogeek.com.



#  Hidden Search Tricks
#   --> You can access many search operators from the search options dialog, but some are hidden. Here’s a list of the hidden ones:

list: # The list: operator allows you to search for messages on a mailing list. For example, list:authors@example.com would return all messages on the authors@example.com mailing list.

filename: # The filename: operator lets you search for a specific file attachment. For example, file:example.pdf would return emails with a file named example.pdf attached.

is:important, label:important # If you use Gmail’s priority inbox, you can use the is:important or label:important operators to search only important or unimportant emails.

has:yellow-star, has:red-star, has:green-check, etc. # If you use different types of stars (see the Stars section on Gmail’s general settings pane), you can search for messages with a specific type of star.

cc:, bcc: # The cc: and bcc: features let you search for messages where a specific address was carbon copied or blind carbon copied. For example, cc:user@example.com returns messages where user@example.com was carbon copied. You can’t use the bcc: operator to search for messages where you were blind carbon copied, only messages where you bcc’d other people.

deliveredto: # The deliveredto: operator looks for messages delivered to a specific address. For example, if you have multiple accounts in the same Gmail inbox, you can use this operator to find the messages sent to a specific address. Use deliveredto:email@example.com to find messages delivered to email@example.com.

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------- #
