#!/usr/bin/env bash

domain="rails.rzd"
orgs=("rzd" "rzd2" "rzd3")

for org in ${orgs[@]}; do
  sed -e "s/\${org}/${org}/g" -e "s/\${domain}/${domain}/g" script-templates/config-peer.sh.tmpl > config-peer-${org}.sh
  sed -e "s/\${org}/${org}/g" -e "s/\${domain}/${domain}/g" script-templates/config-orderer.sh.tmpl > config-orderer-${org}.sh
  chmod +x config-peer-${org}.sh
  chmod +x config-orderer-${org}.sh
done
