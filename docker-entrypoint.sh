#!/bin/sh
set -e
service pcscd start
exec "$@"
