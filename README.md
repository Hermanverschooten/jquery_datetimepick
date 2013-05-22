# Jquery::Datetimepick

This gem adds the necessary stylesheets and javascripts to the jquery-datepick gem to make it a datetimepicker.

The original js/css files are maintained by [Trent Richardson](https://github.com/trentrichardson/jQuery-Timepicker-Addon).

Our version will mirror his version, currently 1.3.

## Installation

Add this line to your application's Gemfile:

    gem 'jquery-datetimepick'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jquery-datetimepick

## Usage

require the stylesheet from your application.css

		//* require jquery-ui-timepicker-addon
		
require the javascript from your applications.js

		//= require jquery-ui-timepicker-addon

And require your translations, for Dutch

		//= require jquery-ui-timepicker-nl

Or add all supported languages

		//= require jquery-ui-timepicker-lang


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
