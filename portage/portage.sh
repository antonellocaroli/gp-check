#!/bin/bash
gp_model=$(sed -n 19p /etc/default/.hw_model)

rsync -a /tmp/gp-check/portage/$gp_model/* /etc/portage/


if [[ ! -f "/var/db/repos/gentoo/check" ]]; then
  rm -rf /var/db/repos/gentoo/*
  rm -rf /var/db/repos/gentoo/.* 2>/dev/null
fi
