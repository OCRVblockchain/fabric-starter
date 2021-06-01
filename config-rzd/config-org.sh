docker rm -f $(docker ps -a -q)
docker volume prune
docker system prune

rm -rf crypto-config/
mkdir crypto-config

cp configtx.yaml crypto-config/configtx.yaml
cp -R fabric-ca crypto-config/fabric-ca

docker-compose -f dockercompose/docker-compose-ca-rzd.yaml up -d && sleep 10

./config-rzd.sh > log1.txt
./config-orderer.sh > log2.txt