#!/bin/sh
echo "Starting module called 03-web-server" >> /tmp/progress.log

systemctl enable --now httpd.service
