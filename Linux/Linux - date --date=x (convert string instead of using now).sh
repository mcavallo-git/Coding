
# Convert from epoch (seconds since 1970) to database format (YYYY-MM-DD hh:mm:ss)
date --date=@1298589405 +'%Y-%m-%d %H:%M:%S'

# Show 1 second just before the epoch
date --utc --date='1969-12-31 23:59:59' +'%s'
