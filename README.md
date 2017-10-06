# u_medical_connection
App who manages connection with medical institutions

## How to set up project
- Install ruby with rails and bundle gems
- Install postgresql
- Change to default postgres user `sudo -u postgres -i`
- Open postgres console `psql`
- Create new role for this project `create role ether createdb login password 'unicorn';`, exit `\q`
- Return to default user `exit`
- Open terminal in `<ProjectPath>/centers-api/`
- Install gems `bundle install`
- Create databases `rake db:setup`

### Soon
- Migrate databases `rake db:migrate`
- Run server `rails rerver`