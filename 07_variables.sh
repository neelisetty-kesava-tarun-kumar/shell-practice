#!/bin/bash 

### Speical Variables ###

echo "All arguments passed to script :: $@"
echo "Number of variables passed through the script :: $#"
echo "Script name :: $0"
echo "Present Directory :: $PWD"
echo "Who is running :: $USER"
echo "Home directory of current user :: $HOME"
echo "PID of the script :: $$"
sleep 1     &
echo "PID of recently executed background command :: $!"
echo "All arguments passed to script :: $*"