SHELL := /bin/bash

HOSTNAME = rmq

PASSPHRASE = $(shell cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

CLIENT_NAME = client

# ---------------------------------------------------------------------------------------------------------------------

.PHONY: $(HOSTNAME)
$(HOSTNAME): $(HOSTNAME)/ca

$(HOSTNAME)/ca: $(HOSTNAME)/ca/cacert.pem $(HOSTNAME)/ca/cacert.cer $(HOSTNAME)/server/cert.pem $(HOSTNAME)/server/keycert.p12 $(HOSTNAME)/$(CLIENT_NAME)/cert.pem $(HOSTNAME)/$(CLIENT_NAME)/keycert.p12

$(HOSTNAME)/ca/certs:
	mkdir -p $@

$(HOSTNAME)/ca/private:
	mkdir -p $@
	chmod 0750 $@

$(HOSTNAME)/ca/serial:
	echo 01 > $@

$(HOSTNAME)/ca/index.txt:
	touch $@

$(HOSTNAME)/ca/openssl.cnf: $(HOSTNAME)/ca/certs $(HOSTNAME)/ca/private $(HOSTNAME)/ca/serial $(HOSTNAME)/ca/index.txt openssl.cnf.template
	cat $(lastword $^) | sed -e 's/$$HOSTNAME/$(HOSTNAME)/g' -e 's/$$CLIENT_NAME/$(CLIENT_NAME)/g' > $@

$(HOSTNAME)/ca/cacert.pem: $(HOSTNAME)/ca/openssl.cnf
	openssl req -x509 -config $< -newkey rsa:2048 -days 3650 -out $@ -outform PEM -subj /CN=$(HOSTNAME)/ -nodes

$(HOSTNAME)/ca/cacert.cer: $(HOSTNAME)/ca/cacert.pem
	openssl x509 -in $< -out $@ -outform DER

$(HOSTNAME)/server $(HOSTNAME)/$(CLIENT_NAME):
	mkdir $@

.SECONDARY: $(HOSTNAME)/server/key.pem $(HOSTNAME)/$(CLIENT_NAME)/key.pem
$(HOSTNAME)/%/key.pem: $(HOSTNAME)/%
	openssl genrsa -out $@ 2048

.SECONDARY: $(HOSTNAME)/server/req.pem $(HOSTNAME)/$(CLIENT_NAME)/req.pem
$(HOSTNAME)/%/req.pem: $(HOSTNAME)/%/key.pem
	openssl req -new -key $< -out $@ -outform PEM -subj /CN=$(HOSTNAME)/O=$(shell basename $(@D))/ -nodes

$(HOSTNAME)/%/cert.pem: $(HOSTNAME)/ca/openssl.cnf $(HOSTNAME)/%/req.pem
	openssl ca -config $(firstword $^) -in $(lastword $^) -out $@ -notext -batch -extensions $(shell basename $(@D))_ca_extensions

$(HOSTNAME)/%/keycert.p12: $(HOSTNAME)/%/key.pem $(HOSTNAME)/%/cert.pem
	openssl pkcs12 -export -out $@ -in $(lastword $^) -inkey $(firstword $^) -passout pass:$$PASSPHRASE

# ---------------------------------------------------------------------------------------------------------------------

.PHONY: certfiles
certfiles: $(HOSTNAME)
	mkdir certfiles
	cp $(HOSTNAME)/ca/cacert.pem certfiles/
	cp $(HOSTNAME)/server/key.pem $(HOSTNAME)/server/cert.pem certfiles/

cleanall:
	rm -rf $(HOSTNAME) Makefile openssl.cnf.template
