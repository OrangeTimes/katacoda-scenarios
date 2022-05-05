#!/bin/bash
pwsh -File ~/.hidden/tests/runTest.ps1 -testLocation '~/.hidden/tests/step01';
if [ $? -eq 0 ] 
then 
  echo "exit 0" >> /tmp/result.txt
  echo "done"
else 
  echo "exit 1" >> /tmp/result.txt
  exit 1
fi


# If the user can proceed the script should output "done" with exit code 0.
# to debug the test, use: <command to debug> >> /tmp/result.txt 2>&1
