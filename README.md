Rails Starter Template with Pay, Devise, and Postgres

# Rails Starter Template with Pay, Devise, and Postgres

This Rails starter template comes with user authentication via Devise, subscription payments via the Pay gem, and PostgreSQL as the database. It's designed to help you quickly set up your Rails application with user authentication and subscription payments.

## Features

- Devise for user authentication
- Pay gem for handling subscription payments with Stripe
- PostgreSQL as the database

## Getting Started

1. Clone the repository

```bash
git clone https://github.com/your-username/rails-starter-template.git
```

2. Change the directory

```bash

cd rails-starter-template
```

3.  Install the required gems

```bash
bundle install
```

4. Update config/database.yml to set up your PostgreSQL credentials and database name

```yaml

default: &default
adapter: postgresql
encoding: unicode
pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
username: your_postgres_username
password: your_postgres_password
host: localhost

development:
<<: \*default
database: your_database_name_development

test:
<<: \*default
database: your_database_name_test

production:
<<: \*default
database: your_database_name_production
username: <%= ENV['POSTGRES_USERNAME'] %>
password: <%= ENV['POSTGRES_PASSWORD'] %>
```

5. Create the database

```bash

rails db:create
rails db:migrate
```

6. Generate a new Rails secret key for your application.

```bash

rails secret
```

Copy the generated key and add it to your config/secrets.yml file or your environment variables for the SECRET_KEY_BASE value:

```yaml
production:
  secret_key_base: your_generated_secret_key_here
```

Or, if you prefer to use environment variables:

```bash

export SECRET_KEY_BASE=your_generated_secret_key_here
```

7. Set up your Stripe API keys in config/initializers/pay.rb or alternatively, add them to the Rails credentials file.

```ruby

Pay.setup do |config|
config.stripe.secret_key = ENV['STRIPE_SECRET_KEY']
config.stripe.public_key = ENV['STRIPE_PUBLIC_KEY']
end
```

Or, to use the Rails credentials file, edit config/credentials.yml.enc by running:

```bash

rails credentials:edit
```

Add the Stripe keys to the file:

```yaml
stripe:
  secret_key: your_stripe_secret_key
  public_key: your_stripe_public_key
```

Then, update config/initializers/pay.rb to use the credentials:

```ruby

Pay.setup do |config|
  config.stripe.secret_key = Rails.application.credentials.dig(:stripe, :secret_key)
  config.stripe.public_key = Rails.application.credentials.dig(:stripe, :public_key)
end
```

8. Update the price ID string in your controller (app/controllers/checkout_controller.rb) with your actual Stripe price ID

```ruby

@checkout_session = current_user.payment_processor.checkout(
mode: "subscription",
line_items: "your_stripe_price_id_here",
success_url: checkout_success_url
)
```

9. Start the Rails server

```bash

rails server
```

Your application should now be up and running with user authentication and subscription payments.

Make sure to replace the placeholders in the database.yml file and the controller with your actual credentials and Stripe price ID.

Happy coding!
# rails-starter-template