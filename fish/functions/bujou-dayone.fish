function bujo-dayone --description "Put Bujo pages into dayone"
	for i in *.png
		set -l d (string match --regex '\d+-\d+-\d+' $i)
		dayone2 --tags BuJouPage --date "$d 23:00" --photos $i -- new BouJo Page
	end
end
