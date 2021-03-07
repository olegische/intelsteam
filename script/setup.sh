#!/bin/bash

# script/setup: Set up application for the first time after cloning, or set it
#               back to the initial first unused state.

set -e

cd "$(dirname "$0")/.."

script/bootstrap.sh
source /tmp/bootstrap-vars

create_netiface_config()
{
    echo "printf \"[Match]\nMACAddress=$( ip addr | grep "${MYIFNAME}": -A1 |\
        grep -Eo 'ether ([0-9a-z]*\:){5}([0-9a-z])*' |\
        grep -Eo '([0-9a-z]*\:){5}([0-9a-z])*' )\n\n[Link]\nName=${MYNEWIFNAME}0\" > /etc/systemd/network/${MYNUM}-${MYNEWIFNAME}.link"
    echo "cat /etc/systemd/network/${MYNUM}-${MYNEWIFNAME}.link"
}

config_netiface()
{
    echo "update-initramfs -u"
}

update_netiface()
{
    echo "sed -i \"s/${MYIFNAME}/${MYNEWIFNAME}0/g\" /etc/network/interfaces"
    echo "cat /etc/network/interface"
}

main()
{
    create_netiface_config
    config_netiface
    update_netiface
}

main | \
while read operation; do
  echo $operation
done
#done | sh

echo "Setup complete. Exit script. Please, reboot."

exit 0
