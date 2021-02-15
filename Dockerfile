FROM ubuntu:21.04

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

RUN apt-get update && apt-get install -y \
    jq \
    libxml2-utils \
    git \
    curl \
    tidy \
    unzip \
    openjdk-11-jdk \
    && git clone https://github.com/OfficialBoomi/boomicicd-cli.git \
    && mkdir ${WORKSPACE}

WORKDIR ${SCRIPTS_HOME}

ADD entrypoint.sh ${SCRIPTS_HOME}/bin/entrypoint.sh
ADD atom_install64.sh /app/boomicicd-cli/cli
ENTRYPOINT [ "/bin/bash","-x", "entrypoint.sh" ]