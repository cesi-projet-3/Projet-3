#!/bin/bash

site_dir='/var/www/carnofluxe.domain'

save=$(ls -l | grep "inc_save" | tail -n1 | sed -r -e 's/.+ //')

if [ -z $save ]; then
    save=$(ls -l | grep "full_save" | tail -n1 | sed -r -e 's/.+ //')
fi

dir="/home/clement/projets/CESI/Projet-3/scripts/$save/carnofluxe.domain"

time=$(uptime | cut -d' ' -f2 | sed -e 's/:/_/g')

inc_dir="inc_save_$time/carnofluxe.domain"

cd $site_dir

find -type f -exec md5sum '{}' \; | sort > md5sum.tmp

cd $dir

find -type f -exec md5sum '{}' \; | sort > md5sum.tmp

nbre_diff=$(grep -f md5sum.tmp -vFx /var/www/carnofluxe.domain/md5sum.tmp | wc -l)

if [ $nbre_diff -gt 0 ]; then
    mkdir -p "../../$inc_dir"
fi

for ((i=1; i < $nbre_diff+1; i++)); do
    file=$(grep -f md5sum.tmp -vFx /var/www/carnofluxe.domain/md5sum.tmp | sed -r -e 's/.+ \.\///' | sed -n $i'p')
    cp -r /var/www/carnofluxe.domain/$file ../../$inc_dir/$file
done

rm $site_dir/md5sum.tmp
rm $dir/md5sum.tmp