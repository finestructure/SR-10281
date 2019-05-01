
LOGFILE=test.log
DRUN=docker run --rm -it -v ${PWD}:/host -w /host

clean:
	rm -rf .build

test-mac: clean
	echo "\ntest-mac" | tee -a ${LOGFILE}
	swift run -c release | tee -a ${LOGFILE}

test-linux-5.0.1: clean
	echo "\ntest-linux-5.0.1" | tee -a ${LOGFILE}
	${DRUN} swift:5.0.1 swift run -c release | tee -a ${LOGFILE}

test-linux-5.0: clean
	echo "\ntest-linux-5.0" | tee -a ${LOGFILE}
	${DRUN} swift:5.0 swift run -c release | tee -a ${LOGFILE}

test-linux-4.2.1: clean
	echo "\ntest-linux-4.2.1" | tee -a ${LOGFILE}
	${DRUN} swift:4.2.1 swift run -c release | tee -a ${LOGFILE}

reset-log:
	rm -f ${LOGFILE}

test: reset-log test-mac test-linux-5.0.1 test-linux-5.0 test-linux-4.2.1
