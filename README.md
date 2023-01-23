# seed_fixtures

[![Gem Version](https://badge.fury.io/rb/seed_fixtures.svg)](https://rubygems.org/gems/seed_fixtures)
[![CI](https://github.com/ghiculescu/seed-fixtures/actions/workflows/ci.yml/badge.svg)](https://github.com/ghiculescu/seed-fixtures/actions/workflows/ci.yml)
[![Code Climate](https://codeclimate.com/github/ghiculescu/seed-fixtures/badges/gpa.svg)](https://codeclimate.com/github/ghiculescu/seed-fixtures)

Use your `seeds.rb` as fixtures when running tests.

Currently only Rails 7 is supported. PRs to support older Rails versions are welcome!

## Quick start

1. Add `seed_fixtures` to the `test` group of your Gemfile, then run `bundle install`.

2. In your `test_helper.rb`:

```ruby
class ActiveSupport::TestCase
  # Add this line:
  fixtures_from_seeds

  # Comment out or remove this line:
  # fixtures :all
end
```

Notes:

- You cannot use standard Rails fixtures if you are using this gem. Make sure you remove the `fixtures` call that's included in `test_helper.rb` by default!
- Ensure your `test_helper.rb` includes this: `require "rails/test_help"`.

3. Add `.seeds_hash` to your `.gitignore` file.

## What it does

- When tests run, the contents of `db/seeds.rb` will be loaded into the test database.
- To improve performance, keeps a hash of everything your app's `db/` folder in the `.seeds_hash` file. This way, seeds are only reloaded into the database if you change your seeds file or your schema.
- Adds a `parallel_setup` hook, so if you run parallel tests, seeds will be loaded correctly. (This is needed because parallel databases [are truncated before each run](https://github.com/rails/rails/issues/46820).)

## How do I access seed data in my test?

Just like anything else in the database...

```ruby
user = User.find_by(name: "Alex")
```

Or if you like, define helper methods for easy lookup.

```ruby
module SeedFixtureLookups
  def user_alex
    @user_alex ||= User.find_by(name: "Alex")
  end
end

class ActiveSupport::TestCase
  include SeedFixtureLookups
end

# in a test...
test "alex exists" do
  assert_not_nil user_alex
end
```

## I thought seeds are for development, not testing!?

Not everyone agrees this is a good idea. And for many apps, it's not! But for some apps it is a very neat way of writing a robust test suite. If your app is one of those, give this a try.

If you're interested, [here's a discusion that touches on pros and cons of this approach](https://discuss.rubyonrails.org/t/should-dbprepare-also-call-db-seed-by-default/74835).

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).
