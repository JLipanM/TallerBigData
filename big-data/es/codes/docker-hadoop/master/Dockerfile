FROM ccosming/hadoop-cluster-base

WORKDIR /root

# Instalando Hive.
RUN wget http://apache.rediris.es/hive/hive-2.3.7/apache-hive-2.3.7-bin.tar.gz && \
    tar xvf apache-hive-2.3.7-bin.tar.gz && \
    mv apache-hive-2.3.7-bin /usr/local/hive && \
    rm apache-hive-2.3.7-bin.tar.gz

# Variables de entorno para Hive.
ENV HIVE_HOME=/usr/local/hive
ENV PATH=$PATH:/usr/local/hive/bin

# Archivo de configuración Hive.
ADD config/hive-site.xml /usr/local/hive/conf/hive-site.xml
RUN chown root:root /usr/local/hive/conf/hive-site.xml

# Se incorpora al sistema de archivos del contenedor el archivo de configuración específico para
# el container "master".
ADD config/bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh

# Se ejecuta script que habilita (ssh, yarn, hdfs).
ENV BOOTSTRAP /etc/bootstrap.sh
CMD [ "/etc/bootstrap.sh", "-d" ]