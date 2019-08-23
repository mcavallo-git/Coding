#!/bin/bash

# ------------------------------------------------------------

# Show FULL Jenkins System Info

jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.info



# ------------------------------------------------------------

# Show the command-line calls/arguments which build the current Jenkins environment

jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" VM.command_line;



# ------------------------------------------------------------

# List all properties/methods in Jenkins' Java runtime environment

jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" help;



# ------------------------------------------------------------

# Show Jenkins' system_property key-vals from its Java runtime environment

jmap -clstats "$(sudo jcmd | grep jenkins | awk '{print $1}')";

jcmd "$(jcmd | grep jenkins | awk '{print $1}')" VM.system_properties;

jcmd "$(sudo jcmd | grep jenkins | awk '{print $1}')" Compiler.directives_print;



# ------------------------------------------------------------