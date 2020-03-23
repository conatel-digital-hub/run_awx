.PHONY: release

release:
	echo $(VERSION) > version \
	&& git commit -am "released version" \
	&& git tag -a $(VERSION) -m "$(VERSION)" \
	&& git push origin master \
	&& git push origin --tags