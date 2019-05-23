set UserID='S-1-5-21-1166796258-588409711-4099699313-1001'
wmic useraccount where sid=%UserID% get * /format:list
