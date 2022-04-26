# GifteryRuby [![Gem Version](https://badge.fury.io/rb/giftery.svg)](https://badge.fury.io/rb/giftery)
The service API documentation link: https://docs.giftery.tech/b2b-api/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'giftery'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install giftery

## Usage

Create client and call `test` operation:
```ruby
client = Giftery::Client.new('<ID>', '<SECRET>')
# check available operations
client.test
```
Example result:
```ruby
{
  "sample_text"=>"Test function works!",
  "available_methods"=>[
    "getProducts",
    "getBalance",
    "getCategories",
    "getAddress",
    "makeOrder",
    "makeBulkOrder",
    "getStatus",
    "getCertificate",
    "getCode",
    "getReport",
    "test",
    "getLinks",
    "makeTopUp",
    "getTopUpStatus",
    "getTopUpLimit"
  ]
}
```

## Development

After checking out the repo, run `bundle install` to install dependencies.
Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`,
and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bdrazhzhov/giftery-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
