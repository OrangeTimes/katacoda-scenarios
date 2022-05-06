#!/bin/bash
pwsh -File ~/.hidden/tests/runTest.ps1 -testLocation '~/.hidden/tests/step01' && echo "done"
# If the user can proceed the script should output "done" with exit code 0.
# To debug the test, use: <command to debug> >> /tmp/result.txt 2>&1
# The command should not throw any errors during it's execution. 
# Even if you return exit 0 but internally it throws an exception the step will fail!!!
