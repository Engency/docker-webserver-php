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

rm -rf dist
mkdir dist

for templateFile in src/*template.Dockerfile; do
  fileName=$(echo "$templateFile" | grep -Po "\K[a-zA-Z\-]*(?=\.template.Dockerfile)")
  distFile="dist/$fileName/Dockerfile"
  mkdir "dist/$fileName"
  cp -R src/config "dist/$fileName"
  touch "$distFile"

  while read -r p; do
    if [[ ${p} =~ ^#include ]]; then
      fileToInclude=$(echo "$p" | grep -Po "(?i)#include \K\d{2}\.[a-zA-Z\-]*(?=\.Dockerfile)")
      cat src/snippets/"$fileToInclude".Dockerfile >>"$distFile"
      echo $"" >>"$distFile"
    else
      echo "${p/$\{tag\}/$tag}" >>"$distFile"
    fi
  done <"$templateFile"
done

echo "Building engency/webserver:$tag-base ..."
docker build dist/base -t "engency/webserver:$tag-base"

for path in dist/*; do
  name=$(basename "$path")
  if [[ "$name" != "base" ]]; then
    echo "Building engency/webserver:$tag-$name ..."
    docker build "$path" -t "engency/webserver:$tag-$name"
    docker push "engency/webserver:$tag-$name"
  fi
done
