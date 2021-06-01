mkdir -p crypto-config/peerOrganizations/rzd2.rails.rzd/
export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd

fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-rzd2 --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"

mkdir -p ${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/msp

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
    OrganizationalUnitIdentifier: orderer' > "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/msp/config.yaml"


fabric-ca-client register --caname ca-rzd2 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"

fabric-ca-client register --caname ca-rzd2 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"

fabric-ca-client register --caname ca-rzd2 --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"


fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-rzd2 -M "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/peers/peer0.rzd2.rails.rzd/msp" --csr.hosts peer0.rzd2.rails.rzd --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"

cp "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/msp/config.yaml" "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/peers/peer0.rzd2.rails.rzd/msp/config.yaml"

fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-rzd2 -M "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/peers/peer0.rzd2.rails.rzd/tls" --enrollment.profile tls --csr.hosts peer0.rzd2.rails.rzd --csr.hosts localhost --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"

cp "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/peers/peer0.rzd2.rails.rzd/tls/tlscacerts/"* "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/peers/peer0.rzd2.rails.rzd/tls/ca.crt"
cp "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/peers/peer0.rzd2.rails.rzd/tls/signcerts/"* "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/peers/peer0.rzd2.rails.rzd/tls/server.crt"
cp "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/peers/peer0.rzd2.rails.rzd/tls/keystore/"* "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/peers/peer0.rzd2.rails.rzd/tls/server.key"


mkdir -p "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/msp/tlscacerts"
sudo cp ${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/peers/peer0.rzd2.rails.rzd/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/msp/tlscacerts/ca.crt

mkdir -p "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/tlsca"
sudo cp ${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/peers/peer0.rzd2.rails.rzd/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/tlsca/tlsca.rzd.rails.rzd-cert.pem

mkdir -p "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/ca"
sudo cp ${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/peers/peer0.rzd2.rails.rzd/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/ca/ca.rzd.rails.rzd-cert.pem


fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-rzd2 -M "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/users/User1@rzd2.rails.rzd/msp" --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"

cp "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/msp/config.yaml" "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/users/User1@rzd2.rails.rzd/msp/config.yaml"

fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:7054 --caname ca-rzd2 -M "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/users/Admin@rzd2.rails.rzd/msp" --tls.certfiles "${PWD}/crypto-config/fabric-ca/rzd2/tls-cert.pem"

cp "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/msp/config.yaml" "${PWD}/crypto-config/peerOrganizations/rzd2.rails.rzd/users/Admin@rzd2.rails.rzd/msp/config.yaml"

