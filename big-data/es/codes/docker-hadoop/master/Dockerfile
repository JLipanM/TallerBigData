FROM ccosming/hadoop-cluster-base

WORKDIR /root

# Se incorpora al sistema de archivos del contenedor el archivo de configuración específico para
# el container "master".
ADD config/bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh

# Se ejecuta script que habilita (ssh, yarn, hdfs).
ENV BOOTSTRAP /etc/bootstrap.sh
CMD [ "/etc/bootstrap.sh", "-d" ]