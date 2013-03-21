# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'billsafe/version'

Gem::Specification.new do |gem|
  gem.name          = "billsafe"
  gem.version       = Billsafe::VERSION
  gem.authors       = ["Mike Zaschka"]
  gem.email         = ["mike.zaschka@gmail.com"]
  gem.description   = %q{Ruby wrapper for the BillSAFE API}
  gem.summary       = %q{Ruby wrapper for the BillSAFE API}
  gem.homepage      = "https://github.com/mikezaschka/ruby-billsafe"
  
  gem.add_development_dependency "rake"
  gem.add_development_dependency "activesupport"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "webmock"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
