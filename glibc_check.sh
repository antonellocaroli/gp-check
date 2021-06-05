#!/bin/sh

glib_installed=$(equery --quiet list  glibc | sed 's/sys-libs\/glibc-//' | cut -c1-4)
gp_model=$(sed -n 16p /etc/default/.hw_model)
if [ "$gp_model" = "Rpi3-64bit" ] ; then
  glib_request=2.33
elif [ "$gp_model" = "Rpi4-64bit" ] ; then
  glib_request=2.33
elif [ "$gp_model" = "x86-64bit" ] ; then
  glib_request=2.32
elif [ "$gp_model" = "Sparky-UsbBridge" ] ; then
  glib_request=2.32
elif [ "$gp_model" = "BBB" ] ; then
  glib_request=2.32
fi
if [ "$glib_installed" = "$glib_request" ] ; then
  echo "no OK" > /tmp/glibok
fi
