#!/bin/bash

site_dir="/var/www/carnofluxe.domain" #we store the site's location

let "nbre_saves=$(ls -l | wc -l)-1" #we count the saves present in the directory (less one, which is a line that isn't representating a file)

if [ $nbre_saves -eq 182 ]; then #if there are 182 files (1 save per day, for 6 months = 182 files)
    filename=$(ls -l | sed -r -e '1d;s/.+ //' | head -n1) #we get the first file which is the older, due to the sorting
    rm $filename #we remove this file
fi

cdate=$(date +%Y_%m_%d) #we get the current date

dir_save="/home/clement/projets/CESI/Projet-3/scripts/full_save_$cdate" #on nomme le dossier de sauvegarde avec la date

mkdir -p $dir_save #On crée le fichier

sudo cp -r $site_dir $dir_save #On copie le contenu du site dans le dossier de sauvegarde

nbre_full_save=$(ls -l | grep "full_save" | wc -l) #On regarde le nombre de dossiers de sauvegarde

if [ $nbre_full_save -gt 1 ]; then #Si c'est plus grand que 1, alors
    dir_to_tar=$(ls -l | grep "full_save" | tail -n2 | sed -r -e '2d;s/.+ //') #On récupère l'avant dernier dossier de sauvegarde complète
    tar zcvf "web_$dir_to_tar.tar.gz" $dir_to_tar 2>&1 > /dev/null #On le compresse
    rm -rf $dir_to_tar #puis on supprime le dossier
fi