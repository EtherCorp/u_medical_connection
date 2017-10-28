# Medical Connection 

## Set up servers

### Redis server

- Install redis
    - For Ubuntu: `sudo apt-get -y install redis-server`
- Start server: `systemctl start redis`

More info: [Quickstart](https://redis.io/topics/quickstart), [Redis queue commands](https://redis.io/commands/lpush)

### MongoDB

- Install Mongo: [Instructions](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/#install-mongodb-community-edition)
- Start server: 
    - For Ubuntu: `sudo mongod`
    - As a service: `systemctl start mongodb`
    
### Sidekiq

- Endpoint access: `localhost:3000/sidekiq`

## Run Unicorn server
- Run Sidekiq `bundle exec sidekiq`
- Run Rails `bundle exec rails server -p 3001`