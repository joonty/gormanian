# Gormanian

I wrote this for the West Midlands Ruby User Group (WMRUG) January 2016 meetup.

Provides a Ruby Date-like library for the Gormanian calendar. Here are some explanatory links:

1. https://www.youtube.com/watch?v=EcMTHr3TqA0
2. http://gormano.blogspot.co.uk/2008/01/problem-solving.html
3. http://slides.com/elaptics/gormanic#/1

## Installation

This looks like a gem, but I haven't actually pushed it to rubygems.org, as it's Just A Bit Of Fun. But who knows what the future holds?

If you really want to install it, clone this repo and run:

```bash
$ bundle install
$ rake install
```

## Usage

```ruby
require "gormanian/date"

# Uses gormanian calendar
date = Gormanian::Date.today
date.to_s          #=> "21 March, 2016"  (Gregorian date is 21 Jan, 2016)
date.day           #=> "21"
date.month         #=> "1"
date.month_name    #=> "March"
date.day_name      #=> "Saturday"
date.saturday?     #=> true
date.intermission? #=> false

# Can add days to get a new date
next_date = date + 1
next_date.to_s     #=> "22 March, 2016"

# Handles intermission
intermission_date = Gormanian::Date.from_gregorian_date(Date.new(2015, 12, 31))
intermission_date.intermission? #=> true
intermission_date.to_s #=> "Intermission, 2015"

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joonty/gormanian. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

