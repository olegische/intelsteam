#!/bin/bash

# Wrapper for ansible | vagrant installation or removement.
# Vagrant installation or removement depends on ansible,
# so ansible will be installed before operations with vagrant
# if it doesn't exists in OS, and will be removed after
# operations with vagrant.
#
# Oleg Romanchuk, 2019-08-20, olromanchuk@gmail.com

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source ${SCRIPT_DIR}/lib/ansible-srv-functions.sh
source ${SCRIPT_DIR}/lib/const.sh
source ${SCRIPT_DIR}/lib/common-functions.sh

# SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# PLAYBOOK_DIR="${SCRIPT_DIR}/playbooks/prov"

USAGE_TXT="Install or remove Ansible service"

usage( )
{
    cat <<EOF
$USAGE_TXT
Usage:
    $PROGRAM [ --? ]
        [ --help ]
        [ --version ]
        [ --install ]
        [ --remove ]
    --install
      Install and config service

    --remove
      Remove service

    --echo
      Echo mode without execution
EOF
}

PROGRAM=`basename $0`
VERSION=1.0

if [ $( whoami ) != 'root' ]; then
    error "Run script as root user."
fi

if [ $# -eq 0 ]; then
    error "Choose required option for script."
fi

cmnd="no"
echo="no"
while test $# -gt 0
do
    case $1 in
    --install | --instal | --insta | --inst | --ins | --in | --i | \
    -install | -instal | -insta | -inst | -ins | -in | -i )
        cmnd='install'
        ;;
    --remove | --remov | --remo | --rem | --re | --r | \
    -remove | -remov | -remo | -rem | -re | -r )
        cmnd='remove'
        ;;
    --help | --hel | --he | --h | '--?' | -help | -hel | -he | -h | '-?' )
        usage_and_exit 0
        ;;
    --version | --versio | --versi | --vers | --ver | --ve | --v | \
    -version | -versio | -versi | -vers | -ver | -ve | -v )
        version
        exit 0
        ;;
    --echo | --ech | --ec | --e | \
    -echo | -ech | -ec | -e )
        echo="yes"
        ;;
    -*)
        error "Unrecognized option: $1."
        ;;
    *)
        break
        ;;
    esac
    shift
done

# Sanity checks for error conditions
if [ $cmnd == 'no' ]; then
    error "Please, choose --install or --remove option."
elif [ ! -d $PLAYBOOK_DIR ]; then
    error "Can't find playbook directory. Please, download whole script directory."
fi
# Sanity checks end

srv_nm="ansible"

if [ $echo == 'yes' ]; then
    service_worker $srv_nm $cmnd | \
    while read operation; do
      echo $operation
    done
elif [ $echo == "no" ]; then
    service_worker $srv_nm $cmnd | \
    while read operation; do
      echo $operation
    done | sh
fi

exit 0
