#!/bin/bash

# script/bootstrap: Resolve all dependencies that the application requires to
#                   run.

set -e

cd "$(dirname "$0")/.."

export_vars()
{
    local myIface=''
    local myNewIface=''
    local myIfaceNum='10'
    echo "echo 'Enter network interface name you want to rename: '"
    read myIface
    local sysIface=$(ip a | grep -Eo 'enp[0-9a-z]?*')
    echo "echo $sysIface"
    if [ $myIface != $sysIface ]; then
        echo "Can't find interface ${myIface}. Exit script."
        exit 1
    fi
    echo "echo 'Enter new network interface name: '"
    read myNewIface

    echo "cat <<EOF >/tmp/bootstrap-vars
        MYIFNAME=$sysIface
        MYNEWIFNAME=$myNewIface
        MYNUM=$myIfaceNum
    EOF"
}

main()
{
    export_vars
}

main | \
while read operation; do
  echo $operation
#done
done | sh

echo "Bootstrap complete. Exit script."

exit 0
