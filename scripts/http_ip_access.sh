#!/bin/bash

log_file='/var/log/apache2/access.log' #Log file of web access

time=$(uptime | cut -d' ' -f2 | sed -e 's/:/_/g') #We get current system's time selecting it with cut, then we replace ":" chars with "_"
date=$(date +%d_%m_) #We get current system's date with "day_minute_" format
filename="access_$date$time.csv" #We name the .csv file with date and time

echo "Heure,Adresse IP" > $filename #We create "hour" and "IP Adress" columns and write it to the csv file
echo "" >> $filename #We create a new line

#We read the log file content and we select only time and IP Adress with the "sed" command, then we add it to the csv file
cat /var/log/apache2/access.log | sed -r -n -e 's/(([0-9]+.){3}[0-9]) .+(([0-9]{2}:){2}[0-9]{2}).+/\3,\1/p' >> $filename

#We create a copy backup of the access.log file in order to empty it
cat $log_file >> "$log_file.bak"

#We empty the log file
echo "" > $log_file