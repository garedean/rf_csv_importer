# RF CSV Importer

### Getting Started

After you have cloned/patched this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

You will need a machine equipped with Ruby and Postgres. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After set up, you can run the application using [Heroku Local]:

    % heroku local

[Heroku Local]: https://devcenter.heroku.com/articles/heroku-local

or

    % rails server

Once the application server is running, navigate tot he following url to access the app:

    http://localhost:3000/

### Running Specs

    bin/rspec
