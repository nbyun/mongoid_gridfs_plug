# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid_gridfs_plug'

Gem::Specification.new do |spec|
  spec.name          = "mongoid_gridfs_plug"
  spec.version       = MongoidGridfsPlug::VERSION
  spec.authors       = ["niebuyun"]
  spec.email         = ["835482737@qq.com"]
  spec.description   = %q{mongoid gridfs plug}
  spec.summary       = %q{}
  spec.homepage      = "https://github.com/nbyun/mongoid_gridfs_plug"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency 'mongoid'
  spec.add_dependency 'mime-types'

end
