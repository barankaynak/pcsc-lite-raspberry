#!/bin/sh

set -e

service pcscd start &

echo waiting for pcscd...
sleep 3

exec "$@"