#!/usr/bin/env sh

user_group=$(groups $(whoami) | awk '{ print $1 }')

sudo chown -R ${USER}:${user_group} aws kube-config ssh
sudo chmod -R 764 aws kube-config ssh
