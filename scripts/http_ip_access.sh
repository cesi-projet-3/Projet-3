#!/bin/bash

log_file='/var/log/apache2/access.log' #Fichier de log d'accès au site web

time=$(uptime | cut -d' ' -f2 | sed -e 's/:/_/g') #on récupère l'heure actuelle du système en le sélectionnant avec cut et en remplaçant les ":" par des "_"
date=$(date +%d_%m_) #on récupère la date actuelle de la machine avec le format "jour_minute_"
filename="access_$date$time.csv" #On nomme le fichier .csv avec la date et l'heure actuelle de création

echo "Heure;Adresse IP" > $filename #On créer les colonnes Heure et Adresse IP en CSV


#on lit le contenu du fichier log, puis on sélectionne seulement l'heure et l'adresse IP avec la commande sed puis on l'écrit à la suite du fichier
cat /var/log/apache2/access.log | sed -r -n -e 's/(([0-9]+.){3}[0-9]) .+(([0-9]{2}:){2}[0-9]{2}).+/\3;\1/p' >> $filename

#on copie le contenu du fichier log dans un fichier bakup pour ensuite le vider
cat $log_file >> "$log_file.bak"

#on vide le contenu du fichier de log
echo "" > $log_file