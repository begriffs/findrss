for path in $(echo {,feed/,feeds/,rss/,blog/}{,all,atom,feed,index,posts,posts/default,rss,en,default,rssfeed,blog}{,.rss,.atom,.rss2}{,.xml,?feed=rss2,?format=atom}); do

	LINE=$(curl -L -s "$1/$path" | head -1)

	if printf "%s" "$LINE" | grep -q -E "feed|xml" ;
	then
		# show canonical redirect location
		curl -sLI -o /dev/null -w '%{url_effective}' "$1/$path"
		echo 
		exit
	fi

done
exit 1
