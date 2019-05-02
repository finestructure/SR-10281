
LOGFILE=test.log
DRUN=docker run --rm -it -v ${PWD}:/host -w /host

clean:
	rm -rf .build

test-mac: clean
	(swift --version && swift run -c release) 2>&1 | tee -a ${LOGFILE}

test-linux-5.0.1: clean
	(${DRUN} swift:5.0.1 swift --version && swift run -c release) 2>&1 | tee -a ${LOGFILE}

test-linux-5.0.0: clean
	# swift@sha256:ccaef3f936bd3cabd184a0caf7c2455eb861182b51e77970be4be72bea116a26 is what used to be swift:5.0
	(${DRUN} swift@sha256:ccaef3f936bd3cabd184a0caf7c2455eb861182b51e77970be4be72bea116a26 swift --version && swift run -c release) 2>&1 | tee -a ${LOGFILE}

test-linux-4.2.1: clean
	(${DRUN} swift:4.2.1 swift --version && swift run -c release) 2>&1 | tee -a ${LOGFILE}

reset-log:
	rm -f ${LOGFILE}

test: reset-log test-mac test-linux-5.0.1 test-linux-5.0.0 test-linux-4.2.1
