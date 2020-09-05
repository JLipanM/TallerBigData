#!/bin/bash

# Iniciando dfs y orquestador yarn.
service ssh start
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh

# Iniciando esquema Hive utilizando el motor derby. 
$HIVE_HOME/bin/schematool -dbType derby -initSchema

bash