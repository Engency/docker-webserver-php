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
mkdir dist/fpm
mkdir dist/webserver

for templateFile in src/webserver/*template.Dockerfile; do
  fileName=$(echo "$templateFile" | grep -Po "\K[a-zA-Z\-]*(?=\.template.Dockerfile)")
  distFile="dist/webserver/$fileName/Dockerfile"
  mkdir "dist/webserver/$fileName"
  cp -R src/config "dist/webserver/$fileName"
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

for templateFile in src/fpm/*template.Dockerfile; do
  fileName=$(echo "$templateFile" | grep -Po "\K[a-zA-Z\-]*(?=\.template.Dockerfile)")
  distFile="dist/fpm/$fileName/Dockerfile"
  mkdir "dist/fpm/$fileName"
  cp -R src/config "dist/fpm/$fileName"
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

echo "Building engency/fpm:$tag-base ..."
docker build dist/fpm/base -t "engency/fpm:$tag-base"

for path in dist/fpm/*; do
  name=$(basename "$path")
  if [[ "$name" != "base" ]]; then
    tagName="$tag-$name"
    if [[ "$name" == "default" ]]; then
      tagName="$tag"
    fi
    echo "Building engency/fpm:$tagName ..."
    docker build "$path" -t "engency/fpm:$tagName"
    docker push "engency/fpm:$tagName"
  fi
done

echo "Building engency/webserver:$tag-base ..."
docker build dist/webserver/base -t "engency/webserver:$tag-base"

for path in dist/webserver/*; do
  name=$(basename "$path")
  if [[ "$name" != "base" ]]; then
    tagName="$tag-$name"
    if [[ "$name" == "default" ]]; then
      tagName="$tag"
    fi
    echo "Building engency/webserver:$tagName ..."
    docker build "$path" -t "engency/webserver:$tagName"
    docker push "engency/webserver:$tagName"
  fi
done
