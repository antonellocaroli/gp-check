#!/bin/bash
gp_model=$(sed -n 19p /etc/default/.hw_model)

rsync -a /tmp/gp-check/portage/$gp_model/* /etc/portage/
