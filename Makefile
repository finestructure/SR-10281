
test-mac:
	swift run

test-linux:
	docker run --rm -it -v ${PWD}:/host -w /host swift:5.0.1 swift run

test: test-mac test-linux
