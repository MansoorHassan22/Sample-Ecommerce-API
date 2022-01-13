# README
##### 1. Check out the repository

```bash
git clone git@github.com:organization/project-name.git
```

##### 2. Create application.yml file

Copy the sample application.yml file and edit the database configuration as required.

```bash
cp config/application-sample.yml config/application.yml
```

Edit this file to add the local database credentials

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rake db:create
rake db:setup
rake db:migrate
rake db:seed
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
rails s
```

And now you can visit the site with the URL http://localhost:3000

##### 5. View API Docs

you can view the api documentation with the URL http://localhost:3000/api-docs/index.html
