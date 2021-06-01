docker rm -f $(docker ps -a -q)
docker volume prune
docker system prune

rm -rf crypto-config/
mkdir crypto-config

cp configtx.yaml crypto-config/configtx.yaml
cp -R fabric-ca crypto-config/fabric-ca

docker-compose -f dockercompose/docker-compose-ca-rzd2.yaml up -d && sleep 10

./config-rzd2.sh > log1.txt
./config-orderer2.sh > log2.txt