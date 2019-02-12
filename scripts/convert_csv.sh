#!/bin/bash

csv_dir="/root/projet"

access=$(ls -l $csv_dir | grep "access" | cut -d' ' -f10)

if [ ! -z $access ]; then
	/usr/local/bin/csv2html "$csv_dir/$access" >> /var/www/carnofluxe.domain/admin/html/access.html
	rm "$csv_dir/$access"
fi

/usr/local/bin/csv2html "$csv_dir/server_status.csv" >> /var/www/carnofluxe.domain/admin/html/status.html

rm "$csv_dir/server_status.csv"
