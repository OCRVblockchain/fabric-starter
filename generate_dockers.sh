#!/usr/bin/env bash

domain="rails.rzd"
orgs=("rzd" "rzd2" "rzd3")

sed -e "s/\${domain}/${domain}/g" docker-templates/docker-compose-ca-orderer.yaml.tmpl > docker-compose-ca-orderer-${org}.yaml
chmod +x docker-compose-ca-orderer-${org}.sh

for org in ${orgs[@]}; do
  sed -e "s/\${org}/${org}/g" -e "s/\${domain}/${domain}/g" docker-templates/docker-compose-ca.yaml.tmpl > docker-compose-ca-${org}.yaml
  sed -e "s/\${org}/${org}/g" -e "s/\${domain}/${domain}/g" docker-templates/docker-compose-orderer.yaml.tmpl > docker-compose-orderer-${org}.yaml
  sed -e "s/\${org}/${org}/g" -e "s/\${domain}/${domain}/g" docker-templates/docker-compose-peer.yaml.tmpl > docker-compose-peer-${org}.yaml
  chmod +x docker-compose-ca-${org}.sh
  chmod +x docker-compose-orderer-${org}.sh
  chmod +x docker-compose-peer-${org}.sh
done
