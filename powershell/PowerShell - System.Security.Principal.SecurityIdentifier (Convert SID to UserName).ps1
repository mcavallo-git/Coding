# ------------------------------------------------------------

# Username to SID (local users)
wmic useraccount get name,fullname,sid

# 
# $namequery = "'name=${Env:USERNAME}'";(wmic useraccount where $namequery get sid);
# 
# (wmic useraccount where name="${Env:USERNAME}" and domain="${Env:USERDOMAIN}" get sid);
# 

# ------------------------------------------------------------

# Username to SID (domain users)
nltest /dclist:${Env:USERDOMAIN};
nltest /dsgetdc:${Env:USERDOMAIN};

wmic /node:"ACQUIRE_FROM_PREVIOUS" /user:"${Env:USERDOMAIN}\${Env:USERNAME}" useraccount get name,fullname,sid;

# ------------------------------------------------------------

# SID to Username, etc.
$SidToLookup = ("S-1-2-34-5678901234-567890123-4567890124-4567")
Get-LocalUser -SID "${SidToLookup}" | Format-List

# ------------------------------------------------------------