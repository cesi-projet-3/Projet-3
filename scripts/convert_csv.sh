#!/bin/bash

csv_dir="/root/projet" #create a vriable which contains the path /root/projet

access=$(ls -l $cvs_dir | grep "acces" |cut -d' ' -f10) #create a variable which contain the name of the csv file IP

if [ ! -z $access ]; then #verifying if file .csv exist
	/usr/local/bin/csv2html "$csv_dir/$access" >> /var/www/carnofluxe.domain/admin/html/access #convert csv file which contain the IP list into an HTML file
	rm "$csv_dir/$access" #then delete the csv file
fi

/usr/local/bin/csv2html "$csv_dir/server_status.csv" >> /var/www/carnofluxe.domain/admin/html/status #convert csv file which contain the IP list into an HTML file

rm "$csv_dir/server_status.csv" #then delete the csv file
