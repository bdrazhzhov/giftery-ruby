# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'giftery/version'

Gem::Specification.new do |spec|
  spec.name          = 'giftery'
  spec.version       = Giftery::VERSION
  spec.authors       = ['Boris Drazhzhov']
  spec.email         = ['templar8@gmail.com']

  spec.summary       = 'Ruby implementation for Giftery (gift cards service) API'
  spec.homepage      = 'https://github.com/bdrazhzhov/giftery-ruby'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.5.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/bdrazhzhov/giftery-ruby'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_dependency 'digest', '~> 3.1.0'
  spec.add_dependency 'http', '~> 5.0.0'
end
