#!/bin/bash
set -xe

if [ "$PACKER_BUILDER_TYPE" != "vsphere-iso" ]; then
    exit 0
fi

if [ -f /etc/os-release ]; then
    # shellcheck disable=SC1091
    source /etc/os-release
    id=$ID
    os_version_id=$VERSION_ID
fi

if [[ $id == "opensuse-leap" ]]; then
    # Maybe try and replace this awful thing with pidof? Its your 10 minutes
    pid=$(ps auxf | grep "/bin/bash /usr/lib/YaST2/startup/YaST2.Second-Stage" | grep -v grep | awk '{pid = $2; print $2}')
    tail --pid=$pid -f /dev/null
    zypper up -y
    zypper install --allow-unsigned-rpm -y https://github.com/vmware/cloud-init-vmware-guestinfo/releases/download/v1.1.0/cloud-init-vmware-guestinfo-1.1.0-1.el7.noarch.rpm
    cloud-init clean
fi