#!/bin/bash -e


apt-get -y install wget
DEB_INSTALLER=cdh5-repository_1.0_all.deb
wget http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/$DEB_INSTALLER
dpkg -i $DEB_INSTALLER

cat > /etc/apt/preferences.d/cloudera.pref <<EOF
Package: *
Pin: release o=Cloudera, l=Cloudera
Pin-Priority: 501
EOF


apt-get -y install hadoop-0.20-mapreduce-jobtracker
apt-get -y install hadoop-hdfs-namenode
apt-get -y install hadoop-hdfs-datanode
apt-get -y install hadoop-client

apt-get -y install spark-core spark-history-server


cat <<EOF # some notes about dependant packages. maybe this is useful, probably not.
The following extra packages will be installed:
  avro-libs bigtop-jsvc bigtop-utils hadoop hadoop-0.20-mapreduce hadoop-hdfs
  hadoop-mapreduce hadoop-yarn parquet parquet-format zookeeper
The following NEW packages will be installed:
  avro-libs bigtop-jsvc bigtop-utils hadoop hadoop-0.20-mapreduce
  hadoop-0.20-mapreduce-jobtracker hadoop-hdfs hadoop-mapreduce hadoop-yarn
  parquet parquet-format zookeeper
0 upgraded, 12 newly installed, 0 to remove and 0 not upgraded.

EOF
