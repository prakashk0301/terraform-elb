#!/bin/bash
sudo yum install -y httpd
sudo service httpd start
sudo chkconfig httpd on
sudo touch /var/www/html/index.html
sudo echo "I am Linux!!" >> /var/www/html/index.html
