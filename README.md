# RF CSV Importer

### About
This is a Ruby on Rails app that allows a user to import CSV 'sales' data; that data is then normalized across a few different tables. The user is shown the total revenue across all sales, along with revenue from a batch immediately after being imported.

### Getting Started

After you have patched this repo, run this setup script to set up your machine
with the necessary dependencies:

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

### Data Normalization

I used the following associations when normalizing imported sales data.

![Data Normalization Chart](http://i.imgur.com/jtM1hpP.png)

### CSV Files for Manual Testing

If you'd like to run some manual tests in the browser, there are two files located under 'spec/fixtures' that represent sales data ([the same example data](https://github.com/renewablefunding/codechallenge/blob/master/example_data.csv) referenced in the codechallenge readme):

  * `sale_test_data.csv`: valid sales data
  * `malformed_sales_test_data.csv`: invalid sales data
