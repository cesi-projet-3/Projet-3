#!/bin/bash

site_dir="/var/www/carnofluxe.domain" #we store the site's location

cd /mnt/saves/web

let "nbre_saves=$(ls -l | wc -l)-1" #we count the saves present in the directory (less one, which is a line that isn't representating a file)

if [ $nbre_saves -eq 182 ]; then #if there are 182 files (1 save per day, for 6 months = 182 files)
    filename=$(ls -l | sed -r -e '1d;s/.+ //' | head -n1) #we get the first file which is the older, due to the sorting
    rm $filename #we remove this file
fi

cdate=$(date +%Y_%m_%d) #we get the current date

dir_save="/mnt/saves/web/full_save_$cdate" #We name the future save directory

mkdir -p $dir_save #We create the folder

cp -r $site_dir $dir_save #We copy all the website's content into the save folder

nbre_full_save=$(ls -l | grep "full_save" | wc -l) #We get other saves folders

if [ $nbre_full_save -gt 1 ]; then #If it is more than 1, so
    dir_to_tar=$(ls -l | grep "full_save" | tail -n2 | sed -r -e '2d;s/.+ //') #We get the one before the last
    tar zcvf "web_$dir_to_tar.tar.gz" $dir_to_tar 2>&1 > /dev/null #We compress it
    rm -rf $dir_to_tar #Then we remove the folder
fi

nbre_inc_save=$(ls -l | grep "inc_save") #Finally, we remove all incremential folder
rm -rf $nbre_inc_save
