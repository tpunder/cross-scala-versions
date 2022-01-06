#!/bin/sh

set -e
set -x

get_versions()
{
  sbt_key=$1
  output_name=$2

  # e.g.) 2.12.14 2.13.7 3.1.0
  versions=$(sbt -Dsbt.supershell=false --error "print $sbt_key" | sed -r 's/\* (.+)/\1/')

  # e.g.) ["2.12.14", "2.13.7", "3.1.0"]
  formatted_versions="[\"$(echo "$versions" | sed '$d' | xargs | sed -e 's/ /", "/g')\"]"

  echo "::set-output name=$output_name::$formatted_versions"
}

# Scala Versions (via crossScalaVersions)
get_versions crossScalaVersions scala_versions

# SBT Versions (via crossSbtVersions)
get_versions crossSbtVersions sbt_versions
