PWD:=$(shell pwd)

ADDONSDK_VERSION?=1.17
ADDONSDK?=addon-sdk-$(ADDONSDK_VERSION)
ADDONSDK_URL?=https://ftp.mozilla.org/pub/mozilla.org/labs/jetpack/$(ADDONSDK).tar.gz

all: firefox/kp-slide.xpi

firefox/kp-slide.xpi: $(ADDONSDK) firefox/data/jquery-1.11.1.min.js firefox/data/kptalks-v1-min.js firefox/lib/main.js
	cd $(ADDONSDK) && source bin/activate && cd $(PWD)/firefox && cfx xpi
	@echo "Firefox extension has been generated to $@"

run: firefox/data/jquery-1.11.1.min.js firefox/data/kptalks-v1-min.js
	cd $(ADDONSDK) && source bin/activate && cd $(PWD)/firefox && cfx run

$(ADDONSDK):
	wget -qO- $(ADDONSDK_URL) | tar xvz

firefox/data/jquery-1.11.1.min.js:
	wget -O $@ http://code.jquery.com/jquery-1.11.1.min.js

firefox/data/kptalks-v1-min.js: src/kptalks-v1-min.js
	cp $? $@

clean:
	rm -rf addon-sdk-* firefox/data/jquery-1.11.1.min.js firefox/data/kptalks-v1-min.js
