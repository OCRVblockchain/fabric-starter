mkdir -p crypto-config/peerOrganizations/rzd.rails.rzd/
export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd

fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-rzd --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd/tls-cert.pem"

mkdir -p ${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/msp

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-rzd.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-rzd.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-rzd.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-rzd.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/msp/config.yaml"


fabric-ca-client register --caname ca-rzd --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd/tls-cert.pem"

fabric-ca-client register --caname ca-rzd --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd/tls-cert.pem"

fabric-ca-client register --caname ca-rzd --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd/tls-cert.pem"


fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-rzd -M "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/peers/peer0.rzd.rails.rzd/msp" --csr.hosts peer0.rzd.rails.rzd --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd/tls-cert.pem"

cp "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/msp/config.yaml" "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/peers/peer0.rzd.rails.rzd/msp/config.yaml"

fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-rzd -M "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/peers/peer0.rzd.rails.rzd/tls" --enrollment.profile tls --csr.hosts peer0.rzd.rails.rzd --csr.hosts localhost --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd/tls-cert.pem"

cp "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/peers/peer0.rzd.rails.rzd/tls/tlscacerts/"* "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/peers/peer0.rzd.rails.rzd/tls/ca.crt"
cp "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/peers/peer0.rzd.rails.rzd/tls/signcerts/"* "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/peers/peer0.rzd.rails.rzd/tls/server.crt"
cp "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/peers/peer0.rzd.rails.rzd/tls/keystore/"* "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/peers/peer0.rzd.rails.rzd/tls/server.key"


mkdir -p "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/msp/tlscacerts"
sudo cp ${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/peers/peer0.rzd.rails.rzd/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/msp/tlscacerts/ca.crt

mkdir -p "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/tlsca"
sudo cp ${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/peers/peer0.rzd.rails.rzd/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/tlsca/tlsca.rzd.rails.rzd-cert.pem

mkdir -p "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/ca"
sudo cp ${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/peers/peer0.rzd.rails.rzd/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/ca/ca.rzd.rails.rzd-cert.pem


fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-rzd -M "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/users/User1@rzd.rails.rzd/msp" --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd/tls-cert.pem"

cp "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/msp/config.yaml" "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/users/User1@rzd.rails.rzd/msp/config.yaml"

fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:7054 --caname ca-rzd -M "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/users/Admin@rzd.rails.rzd/msp" --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd/tls-cert.pem"

cp "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/msp/config.yaml" "${PWD}/crypto-config/peerOrganizations/rzd.rails.rzd/users/Admin@rzd.rails.rzd/msp/config.yaml"
