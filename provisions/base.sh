#!/bin/bash -e


# Add Repo for Oracle Java
add-apt-repository ppa:webupd8team/java -y

# Download and Install the Latest Updates for the OS
apt-get update && apt-get upgrade -y

# Set the Server Timezone to CST
echo "America/Chicago" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata


echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

apt-get -y install oracle-java8-installer


# Based on https://rvm.io/rvm/install
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
source /usr/local/rvm/scripts/rvm

# add vagrant to RVM group
usermod -a -G rvm vagrant

rvm install ruby-2.2.2
echo "source /usr/local/rvm/scripts/rvm" >> /home/vagrant/.bashrc
echo "gem: --no-ri --no-rdoc" > ~/.gemrc


echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> ~/.profile
source ~/.profile

rvm in /vagrant do gem install bundler
rvm in /vagrant do bundle install

# setup Ruby Spark
cp /vagrant/sbt-launch-0.13.7.jar /usr/local/rvm/gems/ruby-2.2.2/gems/ruby-spark-1.2.0/ext/spark/sbt/sbt-launch-0.13.7.jar
rvm in /vagrant do ruby-spark build

# other misc stuff
apt-get -y install unzip htop

byobu-select-backend screen
byobu-enable

