# executeExecutionRequest (asyncronously) by passing the processId and atomId
# Usage : executeExecutionRequest <atomId> <processId>
#!/bin/bash
source bin/common.sh
#execute Process by atomId and processId
ARGUMENTS=(atomName atomType)
OPT_ARGUMENTS=(componentId processName processProperties)

inputs "$@"
if [ "$?" -gt "0" ]
then
        return 255;
fi

source bin/queryAtom.sh atomName="$atomName" atomStatus=online atomType=$atomType

if [ -z "${componentId}" ]
then
	source bin/queryProcess.sh processName="$processName"
fi
processId=${componentId}

if [ -z "${processProperties}" ]
then
	processProperties="[]"
else
	# escape double quotes with \"
	processProperties=`echo $processProperties | sed -e 's/\"/\\\"/g'`
fi

ARGUMENTS=(atomId processId processProperties)
JSON_FILE=json/executeExecutionRequest.json
URL=$baseURL/ExecutionRequest
 
createJSON

callAPI

clean
if [ "$ERROR" -gt "0" ]
then
   return 255;
fi
