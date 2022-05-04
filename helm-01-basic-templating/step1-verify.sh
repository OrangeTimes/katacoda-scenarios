#!/bin/bash
pwsh -File ~/.hidden/tests/runTest.ps1 -testLocation '~/.hidden/tests/step01' && echo "done"
# If the user can proceed the script should output "done" with exit code 0.
# to debug the test, use: <command to debug> >> /tmp/result.txt 2>&1
