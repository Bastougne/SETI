TRACEDIR=secmatv1_2006_04_0809_2000
ZIPFILE=$(TRACEDIR).tgz
UNZIP=tar xzf
TRACEURL=https://sen.enst.fr/system/files/e28c498449fc96d162edd235f8e2b1e8/secmatv1_2006_04_0809_2000.tgz

traces: $(TRACEDIR)

$(ZIPFILE):
	wget $(TRACEURL)

$(TRACEDIR): $(ZIPFILE)
	$(UNZIP) $(ZIPFILE) -m

.PHONY clean:
	rm -f $(ZIPFILE)
	rm -rf $(TRACEDIR)



