#!/bin/bash
# shell script to prepend i3status with more stuff

temperature=""
get_cpu_temperature() {
  temperature=" $(sensors | grep Tctl: | awk '{ print $2 $3}')"
}

i3status | (read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && get_cpu_temperature && while :
do
  read line
  get_cpu_temperature 
  echo ",[{\"full_text\":\"${temperature}     \" },${line#,\[}" || exit 1 
done)
