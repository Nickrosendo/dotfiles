#!/bin/sh
echo " $(sensors | grep Tctl: | awk '{ print $2 $3}')"

