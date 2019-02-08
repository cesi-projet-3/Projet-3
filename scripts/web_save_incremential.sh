#!/bin/bash

site_dir='/var/www/carnofluxe.domain' #We define the website directory

save=$(ls -l | grep "inc_save" | tail -n1 | sed -r -e 's/.+ //') #We search the last incremential save directory

if [ -z $save ]; then #If it doesn't exist, we get the last full save
    save=$(ls -l | grep "full_save" | tail -n1 | sed -r -e 's/.+ //')
fi

dir="/home/clement/projets/CESI/Projet-3/scripts/$save/carnofluxe.domain" #We set the full path of the last save

time=$(uptime | cut -d' ' -f2 | sed -e 's/:/_/g') #We get the current time

inc_dir="/home/clement/projets/CESI/Projet-3/scripts/inc_save_$time/carnofluxe.domain" #We set the full path of the current save

cd $site_dir #We change directory to the website dir

find -type f -exec md5sum '{}' \; | sort > md5sum.tmp #We get all file's md5

cd $dir #We change directory to the last save

find -type f -exec md5sum '{}' \; | sort > md5sum.tmp #We get al file's md5

nbre_diff=$(grep -f md5sum.tmp -vFx /var/www/carnofluxe.domain/md5sum.tmp | wc -l) #We count difference beteen all files

if [ $nbre_diff -gt 0 ]; then #If it is more than 1
    mkdir -p "$inc_dir" #So we create the directory
fi

for ((i=1; i < $nbre_diff+1; i++)); do #For 1 to the number of files which are differents
    file=$(grep -f md5sum.tmp -vFx /var/www/carnofluxe.domain/md5sum.tmp | sed -r -e 's/.+ \.\///' | sed -n $i'p') #We get each file
    cp -r /var/www/carnofluxe.domain/$file $inc_dir/$file #We copy it to the current save directory
done

rm $site_dir/md5sum.tmp #We remove the temporary files
rm $dir/md5sum.tmp