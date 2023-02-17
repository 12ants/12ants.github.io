#!/bin/bash


apt update && apt -y upgrade && apt -y install curl wget sudo

curl -sS https://installer.cloudpanel.io/ce/v2/install.sh -o install.sh; \
echo "f25e3fe3dc028ef8eda281868ab606b5b80bc6ba74a253ae54ab5fd1e61c287d install.sh" | \
sha256sum -c && sudo bash install.sh



