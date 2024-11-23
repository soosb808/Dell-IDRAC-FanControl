#!/bin/sh
function get_temp {
  local TEMP=$(ipmitool -I lanplus -H $IDRAC_HOST -U $IDRAC_USER -P $IDRAC_PW sdr type temperature | grep Exhaust | grep -o -e '[0-9][0-9] degrees' | grep -o -e '[0-9][0-9]')
  echo $TEMP
}

function set_speed {
  ipmitool -I lanplus -H $IDRAC_HOST -U $IDRAC_USER -P $IDRAC_PW raw 0x30 0x30 0x02 0xff $HEX > /dev/null
}

while true; do
TEMP=$(get_temp)
    if [ "$TEMP" -ge 0 ] && [ "$TEMP" -lt 36 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 10%"
        HEX=0x0c 
    elif [ "$TEMP" -ge 36 ] && [ "$TEMP" -lt 41 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 17%"
        HEX=0x11
    elif [ "$TEMP" -ge 41 ] && [ "$TEMP" -lt 46 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 25%"
        HEX=0x19
    elif [ "$TEMP" -ge 46 ] && [ "$TEMP" -lt 51 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 30%"
        HEX=0x1e
    elif [ "$TEMP" -ge 51 ] && [ "$TEMP" -lt 56 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 40%"
        HEX=0x28
    elif [ "$TEMP" -ge 56 ] && [ "$TEMP" -lt 61 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 50%"
        HEX=0x32
    elif [ "$TEMP" -ge 61 ] && [ "$TEMP" -lt 71 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 70%"
        HEX=0x46
    elif [ "$TEMP" -ge 71 ] && [ "$TEMP" -lt 81 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 90%"
        HEX=0x5a
    elif [ "$TEMP" -ge 81 ] && [ "$TEMP" -le 100 ]; then
        echo "Exhaust Temperature is $TEMP : Setting fan speed to 100%"
        HEX=0x64
    else
        echo "Temperature $TEMP: Was not able to get proper tempature"
fi

set_speed

sleep "$CHECK_INTERVAL"s

done