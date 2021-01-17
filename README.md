# boomicicd-cli docker image

This repository is to build a docker image that package the [boomicicd-cli](https://github.com/OfficialBoomi/boomicicd-cli). The CLI utility that wraps calls to Boomi Atomsphere APIs. Handles input and output JSON files and performance orchestration for deploying and managing Boomi runtimes, components and metadata required for CI/CD

## Usage

```bash
$ docker run \
    -e accountId=<your_account_id> \
    -e authToken=BOOMI_TOKEN.<your_username>:<your_atomsphere_api_token>  \
    -ti --rm \
    boomi-cicd-cli:latest <your_command>
```

Where:

- `your_account_id` is the id of the account you are targeting.
  - Go to https://platform.boomi.com/AtomSphere.html#settings
  - Click on `Account Information`
  - Copy the content of the `Account ID` field
- `your_username` is the email you use to login.
  - Go to https://platform.boomi.com/AtomSphere.html#settings
  - Click on `Email Address`
  - Copy the content of the `Email Address` field
- `your_command` the command you want to launch. you can see the complete list into
    https://github.com/OfficialBoomi/boomicicd-cli#list-of-interfaces
