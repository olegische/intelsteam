#!/bin/bash

# script/bootstrap: Resolve all dependencies that the application requires to
#                   run.

set -e

cd "$(dirname "$0")/.."
source script/vars.sh

export_vars()
{
    local sysIface='0'
    local myIface='0'
    local myNewIface='0'
    local myIfaceNum='10'
    echo "echo 'Enter network interface name you want to rename: '"
    read myIface
    for iface in $(ip a | grep BROADCAST | cut -d':' -f2 | sed 's/\ //')
    do
        if [ $iface == $myIface ]; then
            sysIface=$iface
        fi
    done
    if [ $sysIface == '0' ]; then
        echo "Can't find interface ${myIface}. Exit script."
        exit 1
    fi
    echo "echo 'Enter new network interface name: '"
    read myNewIface

    echo "cat <<EOF >${NETCONFIG_VARS}
        netConfigIface=$sysIface
        netConfigIfaceNew=$myNewIface
        netConfigNum=$myIfaceNum
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
