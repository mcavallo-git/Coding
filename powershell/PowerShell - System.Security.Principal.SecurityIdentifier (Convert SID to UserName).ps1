$SidToLookup = ("S-1-2-34-5678901234-567890123-4567890124-4567")
Get-LocalUser -SID "${SidToLookup}" | Format-List
