#!/bin/bash #

csv_file="/root/projet/server_status.csv" #we store the csv in this location 

echo "Status du serveur HTTP,Resolution de nom,accessibilite,Temps de reponse" > $csv_file #we transfert thos text in csv_file

http=$(ping -c 1 192.168.10.10) #create a variable wich contain the ping
if [ $? -eq 0 ]; then #verify if the last word isn't equal to 0
	http_server="actif" #If yes http_server are active
else
	http_server="inactif" #If it is not equal to 0 http_server are inactive
fi 

dns=$(ping -c 1 carnofluxe.domain) #creatte a variable wich ping the DNS
if [ $? -eq 0 ]; then # condition for verify if it's not equal to 0
	dns_server="actif" #active state if the condition is true
else
	dns_server="inactif" # inactive state if the condition is false 
fi

access=$(wget http://localhost) # download file from the server
if [ $? -eq 0 ]; then
	access_status="accessible" #if work state switch on accessible
else
	access_status="inaccessible" #if don't work ,state switch on inaccessible
fi

response=$(ping -c 1 localhost | sed -n -e '2p' | cut -d' ' -f8,9 | sed -e 's/time=//') #Search and show the pourcent of packet lost

echo "$http_server,$dns_server,$access_status,$response" >> $csv_file #Transfert the variables in csv file and show variables

rm index.html #remove the .html file
