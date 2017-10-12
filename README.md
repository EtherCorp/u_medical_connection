# u_medical_connection
## How to set up project 
-install redis: sudo apt-get -y install redis-server
-check server status: sudo service redis-server status
-install mongodb
-Create db dir in / path: 
  -sudo mkdir data
  -sudo cd data
  -sudo mkdir db

## How to run
-start server: redis-server
-start mongodb: mongod
-bundle exec sidekiq
-start project: u_medical_connection/center-api rails s -p 3001
