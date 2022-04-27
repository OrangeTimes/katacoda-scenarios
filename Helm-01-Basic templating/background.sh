#!/bin/bash

echo "This is a background script with a long running process"

curl -L https://get.helm.sh/helm-v3.2.2-linux-amd64.tar.gz | tar xvz && mv linux-amd64/helm /usr/local/bin/helm

echo "done" >> /opt/.backgroundfinished