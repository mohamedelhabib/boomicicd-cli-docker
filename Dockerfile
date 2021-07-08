FROM ubuntu:21.10

WORKDIR /app

## AtomSphere API stuff
ENV accountId=""
# BOOMI_TOKEN.username@company.com:aP1k3y02-mob1-b00M-M0b1-at0msph3r3aa
ENV authToken=
ENV h1="Content-Type: application/json"
ENV h2="Accept: application/json"

## Path stuff
ENV SCRIPTS_HOME=/app/boomicicd-cli/cli/scripts
ENV WORKSPACE=/app/workspace

## Git stuff
ENV gitRepoURL=""
ENV gitUserName=""
ENV gitUserEmail=""
ENV gitRepoName="boomi-components"
ENV gitOption="CLONE"

## Sonar stuff
# If sonar scanner is installed locally then will use the local sonar scanner. Check the sonarScanner.sh
ENV SONAR_HOST=""  
ENV sonarHostURL=""
ENV sonarHostToken=""
ENV sonarProjectKey="BoomiSonar"
ENV sonarRulesFile="conf/BoomiSonarRules.xml"
# Bash verbose output; set to true only for testing, will slow execution.
ENV VERBOSE="false"
# Delays curl request to the platform to set the rate under 5 requests/second
ENV SLEEP_TIMER=0.2

ENV PATH="${SCRIPTS_HOME}/bin:${PATH}"
ENV DEBUG_MODE=""

RUN apt-get update && apt-get install --no-install-recommends -y \
    jq \
    libxml2-utils \
    curl ca-certificates \
    tidy \
    unzip \
    && curl -sLO https://github.com/OfficialBoomi/boomicicd-cli/archive/refs/heads/master.zip \
    && unzip master.zip && rm -fr master.zip && mv boomicicd-cli-master boomicicd-cli \
    && mkdir ${WORKSPACE} \
    && apt-get -y remove unzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR ${SCRIPTS_HOME}

ADD queryExecutionRecordAsync.sh ${SCRIPTS_HOME}/bin/queryExecutionRecordAsync.sh
ADD executeExecutionRequest.sh ${SCRIPTS_HOME}/bin/executeExecutionRequest.sh
ADD executeExecutionRequest.json ${SCRIPTS_HOME}/json/executeExecutionRequest.json
ADD entrypoint.sh ${SCRIPTS_HOME}/bin/entrypoint.sh
ADD atom_install64.sh /app/boomicicd-cli/cli
ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]