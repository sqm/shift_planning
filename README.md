# ShiftPlanning

Ruby client gem for http://www.shiftplanning.com

## Installation

Add this line to your application's Gemfile:

    gem 'shift_planning_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shift_planning_client

## Usage

General usage:

```
client.<api_namespace>.<method>_<endpoint>(required_arg_1, required_arg_2 [, optional_params_hash])
```

```ruby
  client = ShiftPlanning::Client.new(your_api_key)
  client.staff.get_login(username, password, { remember: 1 })
  client.api.get_methods

  ...

  client.staff.get_logout
```

or

```ruby
  shift_planning = ShiftPlanning::AuthenticationKeeper.new('api_key', 'username', 'password')
  shift_planning.run do |c|
    c.timeclock.get_clockin()

    ...

  end
```

Rescue from api errors with:

```ruby
  begin
    ...
  rescue ShiftPlanning::ApiError => e
    ...
  end
```
Api map described in lib/shift_planning/client.rb
For more info follow http://www.shiftplanning.com/api/

To run specs:

```bash
SHIFT_PLANNING_KEY='key' SHIFT_PLANNING_STAFF_USERNAME='username' SHIFT_PLANNING_STAFF_PASSWORD='password' rspec spec
```

## Contributing

1. Fork it ( http://github.com/AskarZinurov/shift_planning/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
