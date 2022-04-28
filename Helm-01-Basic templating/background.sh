#!/bin/bash

echo "This is a background script with a long running process"

curl -L https://get.helm.sh/helm-v3.2.2-linux-amd64.tar.gz | tar xvz && mv linux-amd64/helm /usr/local/bin/helm

wget -q https://github.com/PowerShell/PowerShell/releases/download/v7.2.2/powershell-lts_7.2.2-1.deb_amd64.deb
# Install the downloaded package
sudo dpkg -i powershell-lts_7.2.2-1.deb_amd64.deb
# Resolve missing dependencies and finish the install (if necessary)
sudo apt-get install -f
pwsh -c Install-Module -Name Pester -Force
echo "done" >> /opt/.backgroundfinished