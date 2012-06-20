# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nimbleshop_google_analytics/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Neeraj Singh"]
  gem.email         = ["neeraj@bigbinary.com"]

  gem.description   = %q{ nimbleShop extension for google analytics }
  gem.summary       = %q{ nimbleShop exntesion for google analytics. It also handles e-commerce tracking. }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nimbleshop_google_analytics"
  gem.require_paths = ["lib"]
  gem.version       = NimbleshopGoogleAnalytics::VERSION

  gem.add_dependency('gabba')
  gem.add_dependency('net-http-spy')
end
