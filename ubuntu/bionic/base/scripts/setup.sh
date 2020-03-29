#!/bin/bash -eux

# Issue: https://github.com/boxcutter/ubuntu/pull/74

echo "Disabling unattended upgrades"

cat > /etc/apt/apt.conf.d/51disable-unattended-upgrades << EOF
APT::Periodic::Update-Package-Lists "0";
APT::Periodic::Unattended-Upgrade "0";
EOF

export DEBIAN_FRONTEND="noninteractive"

apt-get update -qq > /dev/null
apt-get dist-upgrade -qq -y > /dev/null

apt-get install -qq -y --no-install-recommends libpam-systemd

if grep -q VBOX /proc/scsi/scsi; then
  echo "*** Installing virtualbox-guest-x11"
  apt-get install -y -qq --no-install-recommends virtualbox-guest-x11
fi