# Jquery::Datetimepick

This gem adds the necessary stylesheets and javascripts to the jquery_datepick gem to make it a datetimepicker.

The original js/css files are maintained by [Trent Richardson](https://github.com/trentrichardson/jQuery-Timepicker-Addon).

Our version will mirror his version, currently 1.3.

## Installation

Add this line to your application's Gemfile:

    gem 'jquery_datetimepick'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jquery_datetimepick

## Usage

require the stylesheet from your application.css

    *= require jquery-ui-timepicker-addon
		
require the javascript from your applications.js

    //= require jquery-ui-timepicker-addon

And require your translations, for Dutch

    //= require jquery-ui-timepicker-nl

Or add all supported languages

    //= require jquery-ui-timepicker-lang

Add this to your view.

    <%= datetime_picker_input "user","birthday" %>
	

Where "event" is your model name and "planned_at" the name of the datetime-field.

You can also use it with the form helper like:

    <% form_for(@event) do |f| %>
      <%= f.datetime_picker 'planned_at' %>
      <%= f.submit 'Create' %>
    <% end %>

Nested attributes are permitted as well:

    <% form_for(@company) do |f| %>
      <% f.fields_for(@event) do |f2| %>
        <%= f2.datetime_picker 'planned_at' %>
      <% end %>
      <%= f.submit 'Create' %>
    <% end %>

You can pass options as it would be a normal text_field, plus all the datepicker options available (http://jqueryui.com/demos/datepicker/#options)

    <%= datetime_picker_input(:foo, :att1, :minDate => -20, :maxDate => "+1M +10D", :tabindex => 70) %>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
