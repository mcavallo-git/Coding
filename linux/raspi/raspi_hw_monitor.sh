#!/bin/bash

watch "\
sudo echo cpu-frequency = $(($(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)/1000))MHz \
&& sudo echo max-frequency = $(($(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq)/1000))MHz \
&& sudo echo cpu-voltage = $(sudo vcgencmd measure_volts 'core')olts \
&& sudo vcgencmd measure_temp \
&& sudo vcgencmd get_mem arm \
&& sudo vcgencmd get_mem gpu \
";
