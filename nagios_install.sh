#!/bin/bash

sudo apt update 
sudo apt upgrade -y
sudo apt install apache2 libapache2-mod-php -y
mkdir nagios
cd nagios
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
wget https://nagios-plugins.org/download/nagios-plugins-2.3.3.tar.gz
sudo useradd -m -s /bin/bash nagios
sudo groupadd nagcmd
sudo usermod -a -G nagcmd nagios
sudo usermod -a -G nagcmd www-data
tar -zxvf nagios-4.4.6.tar.gz
cd nagios-4.4.6
./configure --with-command-group=nagcmd
make all
sudo make install
sudo make install-init
sudo make install-config
sudo make install-commandmode
sudo a2enmod cgi
sudo cp sample-config/httpd.conf /etc/apache2/sites-enabled/nagios.conf
sudo ptpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
sudo service apache2 restart
echo "Open your browser and go to http://raspberryPi_IP/nagios and using username (nagiosadmin) and your password

#END
