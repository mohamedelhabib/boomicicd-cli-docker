#!/bin/bash
export baseURL=https://api.boomi.com/api/rest/v1/${accountId}
# set -x

if [ $# -eq 0 ]
  then
  echo "No arguments supplied. Launch one of the following command $(ls bin/*.sh)"
fi
export SHELLOPTS
exec $@