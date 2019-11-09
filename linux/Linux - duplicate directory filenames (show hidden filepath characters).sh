#!/bin/bash

printf "[%s]\n" *

printf "%s\n" * | cat -vte

printf "%s\n" * | od -bc
