#!/bin/bash

site_dir="/etc/apache2" #we store the site's location

let "nbre_saves=$(ls -l | wc -l)-1" #we count the saves present in the directory (less one, which is a line that isn't representating a file)

if [ $nbre_saves -eq 182 ]; then #if there are 182 files (1 save per day, for 6 months = 182 files)
    filename=$(ls -l | sed -r -e '1d;s/.+ //' | head -n1) #we get the first file which is the older, due to the sorting
    rm $filename #we remove this file
fi

cdate=$(date +%Y_%m_%d) #we get the current date

dir_save="/home/clement/projets/CESI/Projet-3/scripts/full_save_$cdate" #We name the folder for the current save

mkdir -p $dir_save #Directory creation

sudo cp -r $site_dir $dir_save #We copy the whole config into the save directory

nbre_full_save=$(ls -l | grep "full_save" | wc -l) #We look for the numbre of save folders

if [ $nbre_full_save -gt 1 ]; then #If it is more than 1, so
    dir_to_tar=$(ls -l | grep "full_save" | tail -n2 | sed -r -e '2d;s/.+ //') #We get the folder before the last
    tar zcvf "web_$dir_to_tar.tar.gz" $dir_to_tar 2>&1 > /dev/null #We zip it
    rm -rf $dir_to_tar #Then we remove the the save folder to free space
fi

#We get all the incremential folders and we remove them
nbre_inc_save=$(ls -l | grep "inc_save")
rm -rf $nbre_inc_save
