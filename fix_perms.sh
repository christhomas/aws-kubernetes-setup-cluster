#!/usr/bin/env sh

sudo chown ${USER}:${USER} -R aws kube-config ssh
sudo chmod 764 -R aws kube-config ssh