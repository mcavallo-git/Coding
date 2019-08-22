#!/bin/bash

STRING_WITH_LEADING_TRAILING_WHITESPACE="$(echo -e "${STRING_WITH_LEADING_TRAILING_WHITESPACE}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

# Thanks to https://stackoverflow.com/a/3232433