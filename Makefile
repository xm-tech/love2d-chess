build:
	zip -r chess.love *.lua assets
run:
	love chess.love

.PHONY : clean
clean:
	-rm -f chess.love

