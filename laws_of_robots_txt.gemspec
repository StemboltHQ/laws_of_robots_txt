# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'laws_of_robots_txt/version'

Gem::Specification.new do |spec|
  spec.name          = "laws_of_robots_txt"
  spec.version       = LawsOfRobotsTxt::VERSION
  spec.authors       = ["John Hawthorn"]
  spec.email         = ["john@freerunningtechnologies.com"]
  spec.summary       = %q{Rack middleware providing a per-domain robots.txt}
  spec.description   = "1. A robot may not index staging servers\n2. A robot must obey the sitemap\n3. A robot may not injure SEO or, through inaction, cause SEO to come to harm."
  spec.homepage      = "https://github.com/freerunningtech/laws_of_robots_txt"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
end
