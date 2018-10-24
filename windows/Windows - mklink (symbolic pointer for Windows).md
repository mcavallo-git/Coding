	EXIT
	REM ------------------------------------------------------------------------------------------------------------------------------------------------
	
  REM WINDOWS SYMBOLIC LINKS (mklink)
		
	REM ::: GENERAL USAGE:
		mklink /d "[SYMBOLIC-LINK]" "[TARGET]"
		
	REM -- NOTE: [SYMBOLIC-LINK] MUST NOT EXIST WHEN RUNNING MKLINK
		
	REM ------------------------------------------------------------------------------------------------------------------------------------------------
		
		
  REM *** WINDOWS FAX AND SCAN - Sets default scan save location to a different folder other than [My Documents -> Scanned Documents]
		mklink /d "C:\Users\leetb\Documents\Scanned Documents" "C:\Users\leetb\Desktop"
	
	
	
	REM -- USER FOLDER RE-ROUTING - point certain user folders to a general folder (SSD space-saving, File Sharing)
		
    REM -- PHOTOS:
			mklink /d "%USERPROFILE%\Pictures" "G:\My Pictures"
		
    REM -- VIDEOS:
			mklink /d "%USERPROFILE%\Videos" "G:\My Videos"
		
    REM -- DESKTOP:
			mklink /d "%USERPROFILE%\Desktop" "G:\Desktop"
		
		REM -- FRAPS - Point default fraps save location to another folder 
			mklink /d "G:\Fraps\Movies" "G:\My Videos\Fraps Uncompressed"
		
		REM -- ESO - Change location of addons (SSD space-saving)
			mklink /d "%USERPROFILE%\Documents\Elder Scrolls Online\live" "G:\My Documents\OneDrive\TESO Addons"
			
		REM -- GitHub -> Connect to MobaXTerm's base directory
			mklink /d "%USERPROFILE%\Documents\MobaXterm\slash\GitHub" "%USERPROFILE%\Documents\GitHub"
			
	REM ------------------------------------------------------------------------------------------------------------------------------------------------