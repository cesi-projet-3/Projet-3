#!/bin/bash

fichier_csv="info.csv"
echo "Status du serveur DNS,temp de reponse,packets,status HTTP" > $fichier_csv

status=$(service bind9 status | sed -n "3 p" | cut -d' ' -f5)
ping_dns=$(ping -c 1 ns1.carnofluxe.domain | sed -n -e '2p' | cut -d' ' -f8,9 | sed -e 's/time=//')
if [ $? -eq 0]; then
	http_server="actif"
else 
	http_server="inactif"
fi

packet=$(ping -c 1 ns1.carnofluxe.domain | sed -n -e '5p' | cut -d' ' -f6)
if [ $? -eq 0]; then
	dns_server="actif"
else
	dns_server="inactif"
fi

HTTP=$(ping c 1 ... )

echo "$status,$ping_dns,$packet" >> $fichier_csv

scp (chemin du fichier a envoyer) (Nom d'utilisateur@Ip server) (Destination)



