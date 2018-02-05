#!/usr/bin/env sh
set -eu

# Test the proper credentials and configuration are in place before attempting to execute anything
test-setup

export KOPS_STATE_STORE=s3://${BUCKET}

exec $@