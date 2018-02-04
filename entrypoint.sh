#!/usr/bin/env sh

export KOPS_STATE_STORE=s3://${BUCKET}

exec $@