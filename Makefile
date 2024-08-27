.PHONY: snap clean

snap:
	snapcraft -v

clean:
	rm -f *.snap