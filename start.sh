#!/bin/sh

echo "killing ruby process if necessary" >> /home/pi/log
if [ "$(pidof ruby)" ]
then
  kill $(pidof ruby)
fi
echo "starting subscribe process in the background..."  >> /home/pi/log
cd /home/pi/home-ir
/usr/bin/ruby lib/subscribe.rb >> /home/pi/log.2 &
echo "...done" >> /home/pi/log
exit 0
