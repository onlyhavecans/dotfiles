function splitpdf --description "Split PDF(s) in monocrome w/ cleanup"
  if test 0 -eq (count $argv)
    status_message "You need to specify some PDF(s)"
  else
    for p in $argv
    	set -l name (string split --max 2 --right . $p)
    	if test $name[2] != "pdf"
    		status_message "not a pdf file, skipping: $p"
    	else
    		magick convert -density 200 $name[1].pdf -quality 100 -monochrome -statistic median 3 $name[1]-%02d.png
    	end 
    end
  end
end
