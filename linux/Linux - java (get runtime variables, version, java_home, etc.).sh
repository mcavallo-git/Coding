#!/bin/bash
# ------------------------------------------------------------

# show all runtime settings/applied-configurations
java -XX:+PrintFlagsFinal -version 2>&1;


# check parallel threads
java -XX:+PrintFlagsFinal -version 2>&1 | grep -i thread | grep -i parallel;


# check concurrent threads
java -XX:+PrintFlagsFinal -version 2>&1 | grep -i thread | grep -i conc;


# ------------------------------------------------------------

# get java version 
clear; java -XshowSettings:properties -version 2>&1 | grep -i java.version;

# get JAVA_HOME
clear; java -XshowSettings:properties -version 2>&1 | grep -i java.home;


# ------------------------------------------------------------