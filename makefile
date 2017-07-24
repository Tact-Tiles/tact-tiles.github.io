run:
	atom . &
	firefox http://127.0.0.1:4000/ &
	jekyll serve -d /tmp/_site

