# deleteDeployedPackage by passing 
# Usage : deleteDeployedPackage <envName> <processName>
#!/bin/bash
source bin/common.sh
#delete DeployedPackage by <envName> <processName>
ARGUMENTS=(envName processName)

inputs "$@"
if [ -z "${envName}" ] ; then
	echoe "Missing envName param"
	exit 254
fi
if [ -z "${processName}" ] ; then
	echoe "Missing processName param"
	exit 255
fi

bin/queryEnvironment.sh env="${envName}" classification='*'
targetEnvId=$(jq -r ".result[0].id" ${WORKSPACE}/out.json)
if [ -z "${targetEnvId}" ] ; then
	echoe "Environment not found"
	exit 255
fi

bin/queryProcess.sh processName="${processName}"
targetProcessId=$(jq -r ".result[0].id" ${WORKSPACE}/out.json)
if [ -z "${targetProcessId}" ] ; then
	echoe "Process not found"
	exit 255
fi

bin/queryDeployment.sh envId=${targetEnvId} processId=${targetProcessId} current=True
targetPackageId=$(jq -r '.result[0].id' ${WORKSPACE}/out.json)
if [ -z "${targetPackageId}" ] ; then
	echoe "Process ${processName} not deployed into ${envName}"
	exit 0
fi

function deleteAPI {
	unset ERROR ERROR_MESSAGE
	if [ ! -z ${SLEEP_TIMER} ]; then sleep ${SLEEP_TIMER}; fi
	curl --fail -s -X DELETE -u $authToken -H "${h1}" -H "${h2}" "$URL" >"${WORKSPACE}"/out.json
}

URL=$baseURL/DeployedPackage/${targetPackageId}
deleteAPI
