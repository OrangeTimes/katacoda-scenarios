#!/bin/bash
pwsh -File ~/.hidden/tests/runTest.ps1 -testLocation '~/.hidden/tests/chart01' >> /tmp/result.txt 2>&1
echo $? >> /tmp/hello.txt 2>&1