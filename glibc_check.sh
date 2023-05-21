#!/bin/sh

glib_installed=$(equery --quiet list  glibc | sed 's/sys-libs\/glibc-//' | cut -c1-4)
gp_model=$(sed -n 16p /etc/default/.hw_model)
if [ "$gp_model" = "Rpi3-64bit" ] ; then
  glib_request=2.36
elif [ "$gp_model" = "Rpi4-64bit" ] ; then
  glib_request=2.36
elif [ "$gp_model" = "x86-64bit" ] ; then
  glib_request=2.36
elif [ "$gp_model" = "Sparky-UsbBridge" ] ; then
  glib_request=2.36
elif [ "$gp_model" = "BBB" ] ; then
  glib_request=2.36
fi

glib_installedd="${glib_installed//./}"
glib_requestt="${glib_request//./}"

if [ "$glib_installedd" -ge "$glib_requestt" ] ; then
  echo "OK" > /tmp/glibok
fi
