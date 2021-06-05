#!/bin/bash
gp_model=$(sed -n 19p /etc/default/.hw_model)
if [ "$gp_model" = "Rpi3-64bit" ] ; then
  glib_request=2.33
elif [ "$gp_model" = "Rpi4-64bit" ] ; then
  glib_request=2.33
elif [ "$gp_model" = "x86-64bit" ] ; then
  glib_request=2.32
elif [ "$gp_model" = "Sparky-UsbBridge" ] || [ "$gp_model" = "BBB" ] ; then
  glib_request=2.32
fi

if ! cmp -s /tmp/gp-check/portage/$gp_model/audio prova1; then
  echo "diff"
fi


if ! cmp -s prova prova1; then
  echo "diff"
fi

/tmp/gp-check/portage/rpi3/audio

rsync -a /tmp/gp-check/portage/$gp_model/* /etc/portage/
