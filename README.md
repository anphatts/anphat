== README

# Package information
* Ruby version: 2.3.1

* Rails version: 4.2.2

# Setup environment
## Needed package
* Mysql
* Git
* RVM
* Ruby
* Rails

## Set up capistrano

* Clone project setup
```
git clone https://github.com/anphatts/setup.git
```
* Run bundle install
```
bundle install
```
## Setup nginx
* Install it
```
sudo yum install nginx
```
* Create file default.conf
```
sudo vi /etc/nginx/conf.d/default.conf  

```
* Copy the following content to default.conf:
```
 upstream app {
   # Path to Puma SOCK file, as defined previously
   server unix:/deploy/apps/anphat/shared/tmp/sockets/puma.sock fail_timeout=0;
 }

 server {
   listen 80;
   server_name localhost;

   root /deploy/apps/anphat/current/public;

   try_files $uri/index.html $uri @app;

   location / {
     proxy_set_header X-Forwarded-Proto $scheme;
     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
     proxy_set_header X-Real-IP $remote_addr;
     proxy_set_header Host $host;
     proxy_redirect off;
     proxy_set_header Connection '';
     proxy_pass http://app;
     proxy_read_timeout 150;
   }

   location ~ ^/(assets|fonts|system)/|favicon.ico|robots.txt {
     gzip_static on;
     expires max;
     add_header Cache-Control public;
   }

   error_page 500 502 503 504 /500.html;
   client_max_body_size 4G;
   keepalive_timeout 10;
 }
 ```
* Then restart nginx
```
sudo service nginx restart
```
## Create deploy directory
```
mkdir /deploy
mkdir /deploy/apps
mkdir /deploy/apps/anphat
sudo chown -R root:root /deploy/apps/anphat
mkdir /deploy/apps/anphat/shared
mkdir /deploy/apps/anphat/shared/config
nano /deploy/apps/anphat/shared/config/database.yml
```

* Copy the following content to database.yml
```
production:
  adapter: mysql2
  encoding: utf8mb4
  pool: 5
  database: anphatdb
  username: da_admin
  password: anphat.ts
  socket: /var/lib/mysql/mysql.sock
```
* And:
```
nano /deploy/apps/anphat/shared/config/application.yml
```
* Copy
```
SECRET_KEY_BASE: "<your_secret_key_base>"
```
Run 'RAILS_ENV=production rake secret' to generate key and copy to above line
We must add key to environment variables too.
```
sudo nano ~/.bashrc
```
Append this line:
```
export SECRET_KEY_BASE="<your_secret_key_base>"
```
Then:
```
source ~/.bashrc
```

## Deploy and finish
* Go to setup project location
* Run:
```
cap production puma:config
```
* And deploy:
```
cap production deploy
```
