#!/bin/bash

csv_file="/root/projet/server_status.csv"

echo "Status du serveur HTTP,Resolution de nom,accessibilite,Temps de reponse" > $csv_file

http=$(ping -c 1 192.168.10.10)
if [ $? -eq 0 ]; then
	http_server="actif"
else
	http_server="inactif"
fi

dns=$(ping -c 1 carnofluxe.domain)
if [ $? -eq 0 ]; then
	dns_server="actif"
else
	dns_server="inactif"
fi

access=$(wget http://localhost)
if [ $? -eq 0 ]; then
	access_status="accessible"
else
	access_status="inaccessible"
fi

response=$(ping -c 1 localhost | sed -n -e '2p' | cut -d' ' -f8,9 | sed -e 's/time=//')

echo "$http_server,$dns_server,$access_status,$response" >> $csv_file
