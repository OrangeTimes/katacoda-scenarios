#!/bin/bash
echo 'Import-Module Pester -PassThru && Invoke-Pester ~/.hidden/tests/chart01 -CI $true' >> /tmp/hello.txt 2>&1