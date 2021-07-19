#!/bin/bash
gp_model=$(sed -n 19p /etc/default/.hw_model)
gpversion="$(sed -n 1p /etc/default/.GP-version)$(sed -n 2p /etc/default/.GP-version)$(sed -n 3p /etc/default/.GP-version)"

rsync -a /tmp/gp-check/portage/$gp_model/* /etc/portage/

if [ $gpversion -lt 610 ]; then
cat > /etc/portage/repos.conf/gentoo.conf <<EOF
[DEFAULT]
main-repo = gentoo

[gentoo]
location = /var/db/repos/gentoo
#sync-type = rsync
#sync-uri = rsync://rsync.gentoo.org/gentoo-portage
sync-type = git
sync-uri = https://github.com/antonellocaroli/gp_overlay
auto-sync = yes
sync-rsync-verify-jobs = 1
sync-rsync-verify-metamanifest = no
sync-rsync-verify-max-age = 24
sync-openpgp-key-path = /usr/share/openpgp-keys/gentoo-release.asc
sync-openpgp-keyserver = hkps://keys.gentoo.org
sync-openpgp-key-refresh-retry-count = 40
sync-openpgp-key-refresh-retry-overall-timeout = 1200
sync-openpgp-key-refresh-retry-delay-exp-base = 2
sync-openpgp-key-refresh-retry-delay-max = 60
sync-openpgp-key-refresh-retry-delay-mult = 4
sync-webrsync-verify-signature = no
EOF
else
cat > /etc/portage/repos.conf/gentoo.conf <<EOF
[DEFAULT]
main-repo = gentoo

[gentoo]
location = /var/db/repos/gentoo
#sync-type = rsync
#sync-uri = rsync://rsync.gentoo.org/gentoo-portage
sync-type = git
sync-uri = https://github.com/gpoverlay/gpoverlay$gpversion
auto-sync = yes
sync-rsync-verify-jobs = 1
sync-rsync-verify-metamanifest = no
sync-rsync-verify-max-age = 24
sync-openpgp-key-path = /usr/share/openpgp-keys/gentoo-release.asc
sync-openpgp-keyserver = hkps://keys.gentoo.org
sync-openpgp-key-refresh-retry-count = 40
sync-openpgp-key-refresh-retry-overall-timeout = 1200
sync-openpgp-key-refresh-retry-delay-exp-base = 2
sync-openpgp-key-refresh-retry-delay-max = 60
sync-openpgp-key-refresh-retry-delay-mult = 4
sync-webrsync-verify-signature = no
EOF
fi

if [ $gpversion -lt 610 ]; then
  if [[ ! -f "/var/db/repos/gentoo/check" ]]; then
    rm -rf /var/db/repos/gentoo/*
    rm -rf /var/db/repos/gentoo/.* 2>/dev/null
    emerge --sync
  fi
else
  if [[ ! -f "/var/db/repos/gentoo/check$gpversion" ]]; then
    rm -rf /var/db/repos/gentoo/*
    rm -rf /var/db/repos/gentoo/.* 2>/dev/null
    emerge --sync
  fi
fi
