#!/usr/bin/bash

timestamp=$(date +"%Y-%m-%d %H:%M:%S")

echo -e  "\n\n\n=====DISK USAGE REPORT $timestamp=====\n" >> /var/log/server_health.log
df -hP  >> /var/log/server_health.log;

echo -e "\n\n-----checking for disk errors-----" >> /var/log/server_health.log
df -hP  |  awk 'NR>1 {
used = $5;
gsub("%", "", used);

available = 100 - used;

if (available < 10) {
	print "Error: Warning in " $1 " disk space is low only " $5 "is available"
}
}' >> /var/log/server_health.log

echo -e "\n\n\n======MEMORY USAGE REPORT $timestamp======\n" >> /var/log/server_health.log
free -h >> /var/log/server_health.log
echo -e "\n\n-----checking for memory errors-----" >> /var/log/server_health.log
free | awk 'NR>1 {
if ($2 > 0 && $4 / $2 < 0.2){
	print "Error: Warning in " $1 " memory is running low only " $4 / $2 "% is available"
}
}' >> /var/log/server_health.log

echo -e "\n\n\n======CPU USAGE REPORT $timestamp=====\n" >> /var/log/server_health.log
mpstat >> /var/log/server_health.log
echo -e "\n\n-----checking for cpu errors-----" >> /var/log/server_health.log
mpstat | awk 'NR>3 {
if($12 < 20){
	print "Error: Warning CPU usage is above 80% only " $12 "% is idle"
}
}' >> /var/log/server_health.log


echo -e "\n\n\n===== NGINX STATUS REPORT $timestamp=====\n" >> /var/log/server_health.log
service nginx status >> /var/log/server_health.log
echo -e "\n\n-----checking for errors-----" >> /var/log/server_health.log
if systemctl is-active --quiet nginx; then
	echo
else
	echo "Error: Warning NGINX is not active" >> /var/log/server_health.log
	journalctl -u nginx --since today | echo >> /var/log/server_health.log
fi

echo -e "\n\n\n===== ENDPOINT STATUS REPORT $timestamp=====" >> /var/log/server_health.log

status_code=$(curl -s -o /dev/null -w "%{http_code}" http://16.170.115.244/students/)

if [ "$status_code" -ne 200 ]; then
	echo "Error: Warning, students endpoint is down with status code" $status_code >> /var/log/server_health.log
else
	echo "Success: Students endpoint is ok with status code " $status_code >> /var/log/server_health.log
fi

status_code=$(curl -s -o /dev/null -w "%{http_code}" http://16.170.115.244/subjects/)

if [ "$status_code" -ne 200 ]; then
        echo "Error: Warning, subjects endpoint is down with status code" $status_code >> /var/log/server_health.log
else
	echo "Success: Subjects endpoint is ok with status code " $status_code >> /var/log/server_health.log
fi

