# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'datetime_format_converter/version'

Gem::Specification.new do |spec|
  spec.name          = "datetime_format_converter"
  spec.version       = DatetimeFormatConverter::VERSION
  spec.authors       = ["Alexey Osipenko"]
  spec.email         = ["alexey@cimon.io"]

  spec.summary       = %q{Converts ruby date/time format to javascript format of date/time}
  spec.description   = %q{Converts ruby date/time format to javascript format of date/time}
  spec.homepage      = "https://github.com/cimon-io/datetime_format_converter"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
