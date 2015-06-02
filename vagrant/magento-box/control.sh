#!/bin/bash

black='\033[0;30m'
red='\033[0;31m'
green='\033[0;32m'
brownorange='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
lightgray='\033[0;37m'

darkgray='\033[1;30m'
lightred='\033[1;31m'
lightgreen='\033[1;32m'
yellow='\033[1;33m'
lightblue='\033[1;34m'
lightpurple='\033[1;35m'
lightcyan='\033[1;36m'
white='\033[1;37m'

NC='\033[0m'

setTimeZone() {
    echo -e "${green}---- Setting time zone ----${NC}"
    mv /etc/localtime /etc/localtime.bak
    ln -s /usr/share/zoneinfo/America/Edmonton /etc/localtime
}

installWget() {
    echo -e "${green}---- Installing WGET ----${NC}"
    yum install wget -y
}

installExtraYums() {
    echo -e "${green}---- Installing Repos ----${NC}"
    wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
    rpm -ivh epel-release*
    rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
}

updateExistingSSHKey() {
    echo -e "${green}---- Updating existing SSH key ----${NC}"

    rm /home/vagrant/.ssh/bitbucket_key
    cp /vagrant/bitbucket_ssh_key/bitbucket_key /home/vagrant/.ssh/bitbucket_key
    chmod 700 /home/vagrant/.ssh/bitbucket_key
}

setupSSH() {
    echo -e "${green}---- Altering ssh_config to make an SSH key available to everyone ----${NC}"
    sed -i -e '$a\IdentityFile /home/vagrant/.ssh/bitbucket_key' /etc/ssh/ssh_config

    echo -e "${green}---- Altering ssh_config to not check any SSH hosts in a strict fashion ----${NC}"
    sed -i -e '$a\Host bitbucket.org' /etc/ssh/ssh_config
    sed -i -e '$a\    StrictHostKeyChecking no' /etc/ssh/ssh_config

    echo -e "${green}---- Copying the default SSH key and updating the permissions on it ----${NC}"
    cp /vagrant/bitbucket_ssh_key/bitbucket_key /home/vagrant/.ssh/bitbucket_key
    chmod 700 /home/vagrant/.ssh/bitbucket_key
}

installGroup() {
    echo -e "${green}---- Installing Group Packages ----${NC}"
      yum groupinstall 'Development Tools'
}

installPackages() {
    echo -e "${green}---- Installing Packages ----${NC}"
    yum install -y \
        tar \
        nano \
        git \
        build-essential \
        ruby \
        libgcrypt-devel \
        libpng-devel \
        zlib-devel \
        java-1.7.0-openjdk \
        openssl \
        openssl-devel \
        python-setuptools \
        gcc \
        gcc-c++ \
        make \
        npm \
        dos2unix \
        which \
        bzip2 \
        cronie \
        mysql \
        mysql-server \
        rubygems \
        httpd24 \
	mod24_ssl 

    gem install sass
}

installPHP() {
    echo -e "${green}---- Installing PHP & PHPMyAdmin ----${NC}"
    yum install -y \
        php54w \
        php54w-cli \
        php54w-common \
        php54w-gd \
        php54w-mysql \
        php54w-pear \
        php54w-snmp \
        php54w-soap \
        php54w-xml \
        php54w-xmlrpc \
        php54w-mcrypt \
        phpmyadmin
}

installComposer() {
    echo -e "${green}---- Installing composer ----${NC}"
    mkdir -p /opt
    curl -sS https://getcomposer.org/installer | php
    cp composer.phar /usr/local/bin
    mv composer.phar /usr/bin
}

installDrush() {
    echo -e "${green}---- Using PEAR to install drush ----${NC}"
    pear channel-discover pear.drush.org
    pear install drush/drush
    pear upgrade drush/drush
}

installCodeception() {
    echo -e "${green}---- Installing Codeception ----${NC}"
    # wget http://codeception.com/releases/1.8.7/codecept.phar
    # OR
    wget http://codeception.com/codecept.phar
    chmod +x codecept.phar
    mv codecept.phar /usr/bin/codecept
}

setupDefaultMysql() {
    service mysqld start
    #echo -e "${green}---- Setting up default password for ROOT (MySQL) ----${NC}"
    #/usr/bin/mysqladmin -u root password 'root'
}

installDefaultConfs() {
    echo -e "${green}---- Install default configurations ----${NC}"

    # NOTE: You should override this section with custom stuff when you need to
    rm /etc/httpd/conf.d/phpMyAdmin.conf
    cp /vagrant/configs/phpMyAdmin.conf /etc/httpd/conf.d/
    rm /etc/httpd/conf/httpd.conf
    cp /vagrant/configs/httpd.conf /etc/httpd/conf/
    rm /var/www/index.html

    rm /etc/php.ini
    cp /vagrant/configs/php.ini /etc/
    rm /etc/my.cnf
    cp /vagrant/configs/my.cnf /etc/
}

installBetterRSYNC() {
    echo -e "${green}---- Installing Better RSYNC ----${NC}"
    cd /home/vagrant
    wget https://download.samba.org/pub/rsync/src/rsync-3.1.1.tar.gz
    tar -xvf rsync-3.1.1.tar.gz
    cd rsync-3.1.1
    ./configure
    make
    cp rsync /usr/bin/rsync
}

installElasticSearch() {
    echo -e "${green}---- Installing ElasticSearch ----${NC}"
    rpm --import https://packages.elasticsearch.org/GPG-KEY-elasticsearch
    cp /vagrant/configs/elasticsearch.repo /etc/yum.repos.d/
    yum install -y elasticsearch
}

installSOLR() {
    echo -e "${green}---- Installing SOLR ----${NC}"
    cd ~
    mkdir /opt/solr
    wget http://apache.mirrors.tds.net/lucene/solr/5.1.0/solr-5.1.0.tgz
    tar -xvf solr-5.1.0.tgz
    cp -R ./solr-5.1.0 /opt/solr
    mv -v /opt/solr/example /opt/solr/core
    echo -e "${purple}---- To use SOLR: /opt/solr/bin/solr start -noprompt ----${NC}"
}

if [ $1 = "set_timezone" ]; then
    setTimeZone
elif [ $1 = "install_wget" ]; then
    installWget
elif [ $1 = "install_extra_yums" ]; then
    installExtraYums
elif [ $1 = "setup_ssh" ]; then
    setupSSH
elif [ $1 = "update_ssh" ]; then
    updateExistingSSHKey
elif [ $1 = "install_packages" ]; then
    installPackages
elif [ $1 = "install_group" ]; then
    installGroup
elif [ $1 = "install_php" ]; then
    installPHP
elif [ $1 = "install_composer" ]; then
    installComposer
elif [ $1 = "install_drush" ]; then
    installDrush
elif [ $1 = "install_codeception" ]; then
    installCodeception
elif [ $1 = "setup_default_mysql" ]; then
    setupDefaultMysql
elif [ $1 = "install_default_confs" ]; then
    installDefaultConfs
elif [ $1 = "install_better_rsync" ]; then
    installBetterRSYNC
elif [ $1 = "install_solr" ]; then
    installSOLR
elif [ $1 = "build_base" ]; then
    setTimeZone
    installWget
    installExtraYums
    #setupSSH
    installGroup
    installPackages
    installPHP
    installComposer
    installDrush
    installCodeception
    setupDefaultMysql
    installDefaultConfs
    installBetterRSYNC
    installElasticSearch
    installSOLR
elif [ $1 = "test" ]; then
    echo -e "${cyan}---- Testing 1 2 3 ----${NC}"
fi

exit 0
