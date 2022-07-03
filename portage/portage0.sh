#!/bin/bash
gp_model=$(sed -n 19p /etc/default/.hw_model)
gpversion="$(sed -n 1p /etc/default/.GP-version)$(sed -n 2p /etc/default/.GP-version)$(sed -n 3p /etc/default/.GP-version)"


if echo "$gpversion" | grep EXTRM ; then
  rsync -a /tmp/gp-check/portage/"$gp_model""-EXTRM"/* /etc/portage/
else
  rsync -a /tmp/gp-check/portage/"$gp_model"/* /etc/portage/
fi
