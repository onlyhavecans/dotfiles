function bujo-dayone --description "Put Bujo pages into dayone"
	for i in *.png
		set -l d (echo $i | sed -En 's/^([0-9]+-[0-9]+-[0-9]+).*/\1/1p')
		dayone2 --tags BuJouPage --date "$d 23:00" --photos $i -- new BouJo Page
	end
end
