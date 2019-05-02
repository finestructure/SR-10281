#!/bin/sh

LOGFILE=test.log
DRUN="docker run --rm -it -v ${PWD}:/host -w /host"
IMAGES="swift:5.0.1 swift@sha256:ccaef3f936bd3cabd184a0caf7c2455eb861182b51e77970be4be72bea116a26 swift:4.2.1"

rm -f ${LOGFILE}

# macos
rm -rf .build
echo "" | tee -a ${LOGFILE}
swift --version 2>&1 | tee -a ${LOGFILE}
swift run -c release 2>&1 | tee -a ${LOGFILE}

# linux via docker
for IMG in $IMAGES; do
	rm -rf .build
    echo "" | tee -a ${LOGFILE}
	${DRUN} ${IMG} swift --version 2>&1 | tee -a ${LOGFILE}
	${DRUN} ${IMG} swift run -c release 2>&1 | tee -a ${LOGFILE}
done
