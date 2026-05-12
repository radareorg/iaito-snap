.PHONY: snap clean

snap:
	snapcraft pack -v

clean:
	snapcraft clean -v
	rm -vf *.snap
