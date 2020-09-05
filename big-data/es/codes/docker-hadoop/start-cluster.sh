#!/bin/bash

# Crarndo imagen base docker-hadoop.
docker build -f base/Dockerfile -t ccosming/hadoop-cluster-base:latest base

# Crarndo imagen master docker-hadoop.
docker build -f master/Dockerfile -t ccosming/hadoop-cluster-master:latest master

# Número de nodos de nuestro cluster hadoop (3 --> 1 master y 2 slaves).
N=${1:-3}

# Creando red exclusiva para el cluster hadoop (nombre: hadoop)
docker network create --driver=bridge hadoop &> /dev/null

# Levantando contenedores de los servers "slaves" del cluster.
i=1
while [ $i -lt $N ]
do
    docker rm -f hadoop-slave$i &> /dev/null
    echo "start hadoop-slave$i container..."
    docker run -itd \
                    --net=hadoop \
                    --name hadoop-slave$i \
                    --hostname hadoop-slave$i \
                    ccosming/hadoop-cluster-base
    i=$(( $i + 1 ))
done 

# Levantando contenedor del server "master" del cluster.
docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                --name hadoop-master \
                --hostname hadoop-master \
                -v "$(pwd)/data:/data"  \
                ccosming/hadoop-cluster-master

# Opcional: entrar vía bash al container "master".
docker exec -it hadoop-master bash