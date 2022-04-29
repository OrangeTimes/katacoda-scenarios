#!/bin/bash
pwsh -File ~/.hidden/tests/runTest.ps1 -testLocation '~/.hidden/tests/chart01' -CI \$true >> /tmp/hello.txt 2>&1