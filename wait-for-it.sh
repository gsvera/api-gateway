#!/bin/sh
# wait-for-it.sh

# Copiado de https://github.com/vishnubob/wait-for-it

set -e

host=$1
shift
cmd="$@"

until nc -z ${host%:*} ${host#*:}; do
  >&2 echo "Esperando a $host ..."
  sleep 3
done

>&2 echo "$host está listo - ejecutando comando"
exec $cmd
