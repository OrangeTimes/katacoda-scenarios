#!/bin/bash
pwsh -File ~/.hidden/tests/runTest.ps1 -testLocation '~/.hidden/tests/chart01' 
if [ $? -eq 0 ]
then
   exit 0 && echo "done"
else
  echo "The script failed" >> /tmp/result.txt 
  exit 1
fi