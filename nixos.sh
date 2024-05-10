#!/run/current-system/sw/bin/zsh

option="${1}"
status=$?
$cmd="./updateScripts/update.sh ${option}"
$cmd
