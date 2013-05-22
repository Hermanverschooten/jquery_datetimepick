# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jquery_datetimepick/version'

Gem::Specification.new do |gem|
  gem.name          = "jquery_datetimepick"
  gem.version       = JqueryDatetimepick::VERSION
  gem.authors       = ["Herman verschooten"]
  gem.email         = ["Herman@verschooten.net"]
  gem.description   = %q{Rails form helpers for jQuery DateTime picker}
  gem.summary       = %q{This gem requires the jquery_datepick gem and adds the necessary styles and javascripts to make it a datetimepicker}
  gem.homepage      = "http://github.com/Hermanverschooten/jquery_datetimepick"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "jquery_datepick"
end
