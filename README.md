# Medical Connection server for Unicorn

## How to set up project 
- Install Redis and MongoDB
  - On Ubuntu: `sudo apt-get install redis-server mongodb`
- Configure your settings in `/config/` folder
  - We provide a default configuration for al the necessary files 
    just remove the `.default` extension of the files `cable.yml`, `mongoid.yml`, 
    `schedule.yml` and `secrets.yml`

## How to run
- Start mongo and redis service
  - `systemctl start redis`
  - `systemctl start mongodb`
- Run Sidekiq
  - `bundle exec sidekiq`
- Start Medical Connection server 
  - `bundle exec rails server -p 3001`
