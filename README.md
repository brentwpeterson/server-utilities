**These are an effort to help quickly spin up various linux boxes for testing web applications. I am focused on Magento. I am always looking for updates to these scripts** 

# utilities
- This is used for scripts that are not tied to a particular server install

# amazon
- Scripts for misc utilities
- Setup a PHP5.4 and MySQL 5.5 server from the standard AMI
- Setup a PHP5.4 and Percona 5.6 server
- Apache 2.4

# centos
- For centos
- The standard will install php 5.3 and apache 2.2

# ubuntu
- Ubuntu server 12
- Ubuntu Desktop 14
- I would love to get help on these

# magento
- Includes Magento specific scripts
- 
# vagrant
- Vagrant box - it's just a start

# Permissions
From here [http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-LAMP.html](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-LAMP.html)

###### Apache config
- Find and replace the Apache user and group with your *user* and the group *www*

###### NGINX config
- Change the NGINX user and also the php-fpm user

###### Groups
- To set file permissions
	- sudo groupadd www
	- sudo usermod -a -G www ec2-user

- Change the group ownership of /var/www and its contents to the www group. (*This should be for new builds*)
	- sudo chown -R root:www /var/www
	- sudo chmod 2775 /var/www
	- find /var/www -type d -exec sudo chmod 2775 {} +
	- find /var/www -type f -exec sudo chmod 0664 {} +






*Brent W. Peterson 2015*
