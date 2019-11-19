# What is DokuWiki?
DokuWiki is a simple to use and highly versatile Open Source wiki software that doesn&#39;t require
a database. It is loved by users for its clean and readable syntax. The ease of maintenance,
backup and integration makes it an administrator&#39;s favorite. Built in access controls and
authentication connectors make DokuWiki especially useful in the enterprise context and the
large number of plugins contributed by its vibrant community allow for a broad range of use
cases beyond a traditional wiki.
# Why I built this image.
I was looking for a simple Dokuwiki image with SSL enabled, but could not find anything that
fit my needs. Having no real experience with docker, I decided that this would be a good project
to get started learning docker, and how to build images.
# How to run this image:
Use one of the following methods to run this image.</br>
NOTE: If using volumes or bind mounts, the first time that you start the image, it will take about
1 minute for the web data to be copied to the volumes. Please be patient and wait about 60
seconds for the data to be copied.</br>
NOTE: After waiting about 1 minute for the web data to be copied to the volumes, please visit
https://server_address:ssl_port/install.php to complete the DokuWiki installation. This page will
allow you to name your DokuWiki site and set up the superuser account.</br>
NOTE: To use custom certificates, overwrite the public and private key files in the certs/ folder on the
apache2 volume and also modify the ServerName on the last line of the apache2.conf file on the
apache2 volume.
### Using docker run with bind mounts:
Assuming that you are storing persistent data in /volumes/dokuwiki/web/ and that you would like
to use ports 4443 and 4080.</p>
docker run -d -p 4443:443 -p 4080:80 --name my_wiki \\</br>
-v /volumes/dokuwiki/web/data:/var/www/html/data \\</br>
-v /volumes/dokuwiki/web/lib:/var/www/html/lib \\</br>
-v /volumes/dokuwiki/web/conf:/var/www/html/conf \\</br>
-v /volumes/dokuwiki/web/apache2:/etc/apache2 \\</br>
amercat37/dokuwiki:7311ab.20180422b.01
### Using docker-compose:
docker-compose up -d
### Using docker swarm:
docker stack deploy -c docker-compose.yml dokuwiki
# Tag Naming.
Tags are named using the php image that I used to build my image, followed by the DokuWiki
version, followed by my revision number. The initial image was built using the official
php:7.3.11-apache-buster image and DokuWiki 2018-04-22b &quot;Greebo&quot;. This is where
7311ab.20180422b.01 comes from. I will not be releasing new images very often because
Dokuwiki does not release new versions very often. When new DokuWiki versions are available,
I will attempt to release a new image using the latest php apache debian image.
# Additional Information.
Visit please visit <a href="https://hub.docker.com/repository/docker/amercat37/dokuwiki">my dockerhub page</a> for available tags and pull information for this project.
