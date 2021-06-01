mkdir -p crypto-config/ordererOrganizations/rzd2.rails.rzd/
export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd

fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-rzd2 --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"

mkdir -p ${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/msp

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-rzd2.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-rzd2.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-rzd2.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-rzd2.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/msp/config.yaml"


fabric-ca-client register --caname ca-rzd2 --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"

fabric-ca-client register --caname ca-rzd2 --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"


fabric-ca-client enroll -u https://orderer:ordererpw@localhost:7054 --caname ca-rzd2 -M "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/orderers/orderer.rzd2.rails.rzd/msp" --csr.hosts orderer.rzd2.rails.rzd --csr.hosts orderer.rzd.rails.rzd --csr.hosts localhost --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"

cp "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/msp/config.yaml" "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/orderers/orderer.rzd2.rails.rzd/msp/config.yaml"

fabric-ca-client enroll -u https://orderer:ordererpw@localhost:7054 --caname ca-rzd2 -M "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/orderers/orderer.rzd2.rails.rzd/tls" --enrollment.profile tls --csr.hosts orderer.rzd2.rails.rzd --csr.hosts orderer.rzd.rails.rzd --csr.hosts localhost --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"

cp "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/orderers/orderer.rzd2.rails.rzd/tls/tlscacerts/"* "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/orderers/orderer.rzd2.rails.rzd/tls/ca.crt"
cp "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/orderers/orderer.rzd2.rails.rzd/tls/signcerts/"* "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/orderers/orderer.rzd2.rails.rzd/tls/server.crt"
cp "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/orderers/orderer.rzd2.rails.rzd/tls/keystore/"* "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/orderers/orderer.rzd2.rails.rzd/tls/server.key"


mkdir -p "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/orderers/orderer.rzd2.rails.rzd/msp/tlscacerts"
sudo cp ${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/orderers/orderer.rzd2.rails.rzd/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/orderers/orderer.rzd2.rails.rzd/msp/tlscacerts/tlsca.rails.rzd-cert.pem

mkdir -p "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/msp/tlscacerts"
sudo cp ${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/orderers/orderer.rzd2.rails.rzd/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/msp/tlscacerts/tlsca.rails.rzd-cert.pem


fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:7054 --caname ca-rzd2 -M "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/users/Admin@rails.rzd/msp" --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"

cp "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/msp/config.yaml" "${PWD}/crypto-config/ordererOrganizations/rzd2.rails.rzd/users/Admin@rails.rzd/msp/config.yaml"
  
