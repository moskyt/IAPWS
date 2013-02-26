# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iapws/version'

Gem::Specification.new do |gem|
  gem.name          = "iapws"
  gem.version       = Iapws::VERSION
  gem.authors       = ["Frantisek Havluj"]
  gem.email         = ["moskyt@rozhled.cz"]
  gem.description   = %q{IAPWS IF97 formulas}
  gem.summary       = %q{Gem for water density, iapws 97, region 1 -- maybe something more in the future}
  gem.homepage      = "http://orf.ujv.cz"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
