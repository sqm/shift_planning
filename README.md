# ShiftPlanning

Ruby client gem for http://www.shiftplanning.com

## Installation

Add this line to your application's Gemfile:

    gem 'shift_planning'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shift_planning

## Usage

Call client.<api_namespace>.<method>_<endpoint>(required_arg_1, required_arg_2 [, optional_params_hash])

```ruby
  client = ShiftPlanning::Client.new(your_api_key)
  client.staff.get_login(username, password, { remember: 1 })
  client.api.get_methods

  ...

  client.staff.get_logout
```

Rescue from api errors with:

```ruby
  begin
    ...
  rescue ShiftPlanning::ApiError => e
    ...
  end
```
For more info follow http://www.shiftplanning.com/api/

## Contributing

1. Fork it ( http://github.com/AskarZinurov/shift_planning/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
