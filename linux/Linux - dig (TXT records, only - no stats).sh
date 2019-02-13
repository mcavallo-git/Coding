#!/bin/sh


# use [ dig ] module to acquire a host's TXT records, specifically
dig _github-challenge-ORGANIZATION.example.com +nostats +nocomments +nocmd TXT
