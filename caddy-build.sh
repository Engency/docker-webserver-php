#!/bin/bash

tag=dev
while getopts ":t:" opt; do
  case $opt in
  t)
    tag=${OPTARG}
    shift $((OPTIND - 1))
    ;;
  *) ;;
  esac
done

echo "Building engency/caddy:$tag ..."
docker build src/caddy -t "engency/caddy:$tag"
docker push "engency/caddy:$tag"
