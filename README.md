# README
## Introduction
ChatBot is a Rails 7.0.1 application built as an API that allows users to intereact with the program to perform Deposit Inquiries, Request paper rolls and Economic indicator inquiries. The application requires Ruby '3.0.1' to be installed. Before running the application, it is important to create a `.env.development.local` and `.env.test.local` files to load your database configuration.

## Installation
To install Chatbox, follow these steps:

1. Clone the repository: 

    `https://github.com/Alexis077/chatbot.git`

2. Install the required dependencies:

    `bundle install`

3. Create a `.env.development.local` and a `.env.test.local` file with the following keys:

    ```
    DATABASE_USERNAME=YOUR_POSTGRES_USER
    DATABASE_PASSWORD=YOUR_POSTGRES_PASSWORD
    DATABASE_HOST=YOUR_POSTGRES_HOST
    ```
4. Create development and test database running:
   `rake db:create`

5. Migrate development database:
   `rake db:migrate`

6. Migrate test database:
   `rake db:migrate RAILS_ENV=test`

7. Run the seed script to fill the database with test data:
   `rake db:seed`

8. Run the application:
    `rails s`

9. To open the app and got to your browser and write the following localhost address:
    `http://localhost:3000`

## About node and ruby version manager. 

This project was build with asdf version manager
follow the instructions depending your operative system
https://asdf-vm.com/.

Once installed install the required plugins

`asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git`

`asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git`

Install the required dependencies:

```
sudo apt-get update
sudo apt-get install -y \
  autoconf \
  bison \
  build-essential \
  libssl-dev \
  libyaml-dev \
  libreadline-dev \
  zlib1g-dev \
  libncurses5-dev \
  libffi-dev \
  libgdbm6 \
  libgdbm-dev

```

Add the required versions of ruby and node js for this project:

`asdf install ruby 3.0.1`

`asdf install nodejs 14.21.2`

You can use ethier RVM or RBENV the only diference will be that you have to install a nodejs runtime environment as global version.  