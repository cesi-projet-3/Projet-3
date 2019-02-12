#!/bin/bash

csv_dir="/root/projet"

access=$(ls -l $cvs_dir | grep "acces" |cut -d' ' -f10)

if [ ! -z $access ]; then
	/usr/local/bin/csv2html "$csv_dir/$access" >> /var/www/carnofluxe.domain/admin/html/access
	rm "$csv_dir/$access"
fi

/usr/local/bin/csv2html "$csv_dir/server_status.csv" >> /var/www/carnofluxe.domain/admin/html/status

rm "$csv_dir/server_status.csv"
