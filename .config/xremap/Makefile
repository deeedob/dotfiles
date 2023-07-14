DESTDIR = /opt/xremap

install:
	install -d $(DESTDIR)
	# Install the config.yml file
	install -m 644 config.yml $(DESTDIR)
	# Install the xremap.service file
	install -m 644 xremap.service /etc/systemd/system
	# Install the xremap_start script
	install -m 755 xremap_start $(DESTDIR)

.PHONY: install

