# SnowService

This is another attempt to a simple service object in Ruby.

The first twist is that the service will return self, allowing to do:

```ruby
if (creation = CreateUser.call(name: "Bob")).succeeded?
  user = creation.user
  …
else
  raise creation.errors
end
``` 

Second twist is the freezing of the instance after calling to reasonably prevent change of states
in the service object once the call method is done.
The intention is to be sure that the state of the instance is stable and only dependent of initial params.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'snow_service'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install snow_service

## Usage

To create a service:

```ruby
class CreateUser < SnowService::Base
  def perform
    # `params` will include all parameters passed to the initializer (or you can override your own)
    @user = User.new(params)
    @succeeded = @user.save
  end
  
  def succeeded?
    @succeeded
  end
  
  def user
    @user
  end
  
  def errors
    @user.errors.full_messages
  end
end
```

To use it:

```ruby
user_creation = CreateUser.call(first_name: "John", last_name: "Doe")
if user_creation.succeeded?
  user = user_creation.user
else
  raise user_creation.errors.first
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dbourguignon/snow_service. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SnowService project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/dbourguignon/snow_service/blob/master/CODE_OF_CONDUCT.md).
