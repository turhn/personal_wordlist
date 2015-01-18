$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'personal_wordlist/version'

Gem::Specification.new do |s|
  s.name       = 'personal_wordlist'
  s.version    = PersonalWordlist::VERSION
  s.date       = '2015-01-18'
  s.summary    = 'Create wordlists from personal data.'

  s.authors    = ['Turhan Coskun']
  s.email      = 'turhancoskun@gmail.com'

  s.files = `git ls-files`.split("\n").reject { |path| path =~ /\.gitignore$/ }
  s.test_files = `git ls-files -- Appraisals {spec,features,gemfiles}/*`
    .split("\n")

  s.require_paths = ['lib']
  s.required_ruby_version = Gem::Requirement.new('>= 1.9.2')
  s.add_development_dependency('rspec')

  s.license   = 'MIT'
end
