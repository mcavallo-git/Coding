#!/bin/bash


# Get Jenkins' system_property key-vals from its Java runtime environment
jcmd "$(jcmd | grep jenkins | awk '{print $1}')" "VM.system_properties";


# Show other callable arguments/methods in Jenkins' Java runtime environment
jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" help;
