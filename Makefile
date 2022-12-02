build:
	zip -r chess.love *.lua assets
run:
	love chess.love
clean:
	rm -f chess.love

