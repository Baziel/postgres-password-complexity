#!/bin/bash
set -e
echo START postgres.sh
/usr/pgsql-17/bin/initdb -D /pgdata/data -E UTF8 --auth-host=trust --auth-local=trust



