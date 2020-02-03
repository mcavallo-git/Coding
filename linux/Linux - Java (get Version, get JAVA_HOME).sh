#!/bin/bash

# get java version 
clear; java -XshowSettings:properties -version 2>&1 | grep -i java.version;

# get JAVA_HOME
clear; java -XshowSettings:properties -version 2>&1 | grep -i java.home;
