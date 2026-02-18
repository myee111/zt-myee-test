#!/bin/sh
echo "Starting module called 01-timezone" >> /tmp/progress.log

KATELLO=$(rpm -qa | grep katello-ca)

cd /root

rpm -e $KATELLO
subscription-manager unregister
subscription-manager clean
subscription-manager register --activationkey=12-5-22-instruqt --org=12451665 --force
