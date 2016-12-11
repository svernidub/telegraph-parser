# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'telegraph/parser/version'

Gem::Specification.new do |spec|
  spec.name          = "telegraph-parser"
  spec.version       = Telegraph::Parser::VERSION
  spec.authors       = ["Sergey Vernidub"]
  spec.email         = ["svernidub@gmail.com"]

  spec.summary       = %q{Gem to pull and parse articles from Telegra.ph.}
  spec.homepage      = "https://github.com/svernidub/telegraph-parser"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri", "~> 1.6.8"
end