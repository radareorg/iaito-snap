.PHONY: snap clean

snap:
	snapcraft -v

clean:
	snapcraft clean -v
	rm -vf *.snap
