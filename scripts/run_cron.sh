#!/bin/sh

set | sed 's/^/export /' > /var/tmp/env.sh

cron -f
