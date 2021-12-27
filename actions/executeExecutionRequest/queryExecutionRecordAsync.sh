#!/bin/bash

source bin/common.sh
# get atom id of the by atom name
# mandatory arguments
ARGUMENTS=(requestId)
# OPT_ARGUMENTS=(failOnError)
inputs "$@"
if [ "$?" -gt "0" ]; then
       return 255
fi

# if [ -z "${failOnError}" ]; then
#        failOnError="false"
# fi

URL=$baseURL/ExecutionRecord/async/${requestId}
getAPI
