[[_TOC_]]

# Code block - No language specification
```
START_SECONDS_NANOSECONDS=$(date +'%s.%N');
START_EPOCHSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 1);
START_NANOSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-9);
START_MICROSECONDS=$(echo ${START_NANOSECONDS} | cut --characters 1-6);
START_DATETIME="$(date --date=@${START_EPOCHSECONDS} +'%Y-%m-%d %H:%M:%S';)";
START_TIMESTAMP="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d_%H%M%S';)";
```


# Code block - Bash language specification
```bash
START_SECONDS_NANOSECONDS=$(date +'%s.%N');
START_EPOCHSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 1);
START_NANOSECONDS=$(echo ${START_SECONDS_NANOSECONDS} | cut --delimiter '.' --fields 2 | cut --characters 1-9);
START_MICROSECONDS=$(echo ${START_NANOSECONDS} | cut --characters 1-6);
START_DATETIME="$(date --date=@${START_EPOCHSECONDS} +'%Y-%m-%d %H:%M:%S';)";
START_TIMESTAMP="$(date --date=@${START_EPOCHSECONDS} +'%Y%m%d_%H%M%S';)";
```

# Code block - No language specification
```
# Desktop Background Color
$RegEdits += @{
  Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Control Panel\Colors";
  Props=@(
    @{
      Description="Defines a user's desktop background color using space-delimited R G B syntax (such as '255 255 255' for white, '255 0 0' for red, '0 255 0' for green, and '0 0 255' for blue)";
      Name="Background";
      Type="String";
      Value="34 34 34";
      Delete=$False;
    }
  )
};
```


# Code block - Powershell language specification
```powershell
# Desktop Background Color
$RegEdits += @{
  Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Control Panel\Colors";
  Props=@(
    @{
      Description="Defines a user's desktop background color using space-delimited R G B syntax (such as '255 255 255' for white, '255 0 0' for red, '0 255 0' for green, and '0 0 255' for blue)";
      Name="Background";
      Type="String";
      Value="34 34 34";
      Delete=$False;
    }
  )
};
```