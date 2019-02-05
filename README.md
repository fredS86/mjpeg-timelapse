Scripts to make a timelapse with MJPEG cameras on HTTP.

exemple of usage
take an image every 12minutes from 10:00 am every day
0 10 * * * cd /home/pi/mjpeg-timelapse && ./timelapse.sh ./timelapseVideo "http://localhost:8090/?action=snapshot" 12m 50 >> /home/pi/cron.log 2>&1

send today images to an external support, for exemple a NAS drive mounted at /nas
10 20 * * * cd /home/pi/mjpeg-timelapse && ./move2local.sh ./timelapseVideo /nas/timelapse/timelapseVideo >> /home/pi/cron.log 2>&1

