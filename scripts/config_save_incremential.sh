config_dir='/etc/apache2/'

cd /mnt/saves/config

save=$(ls -l | grep "full_save" | tail -n1 | sed -r -e 's/.+ //')

if [ -z $save ]; then
	save=$(ls -l | grep "full_save" | tail n-1 | sed -r -e 's/.+ //')
fi

dir="/mnt/saves/config/$save/apache2"

time=$(uptime | cut -d' ' -f2 | sed -e 's/:/_/g')

inc_dir="/mnt/saves/config/inc_save_$time/apache2"

cd $config_dir

find -type f -exec md5sum '{}' \; | sort > md5sum.tmp

cd $dir

find -type f -exec md5sum '{}' \; | sort > md5sum.tmp

nbr_diff=$(grep -f md5sum.tmp -vFx /etc/apache2/md5sum.tmp | wc -1)

if [ $nbr_diff -gt 0 ]; then
	mkdir -p "$inc_dir"
fi

for ((i=1; i < $nbr_diff+1; i++)); do
	file=$(grep -f md5sum.tmp -vFx /etc/apache2/md5sum.tmp | sed -r -e 's/.+ \._///' | sed -n $i'p')
	cp -r /etc/apache2/$file $inc_dir/$file
done

rm $config_dir/md5sum.tmp
rm $dir/md5sum.tmp
