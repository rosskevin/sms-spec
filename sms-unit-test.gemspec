# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'sms_unit_test/version'

Gem::Specification.new do |s|
  s.name        = 'sms-unit-test'
  s.version     = SmsUnitTest::VERSION
  s.authors     = ['Kevin Ross']
  s.email       = ['kevin.ross@alienfast.com']
  s.homepage    = 'https://github.com/rosskevin/sms-unit-test'
  s.summary     = %q{Test SMS interactions with RSpec and Cucumber}
  s.description = %q{SMS Spec gives you an RSpec DSL and Cucumber steps to test SMS interactions.}

  s.rubyforge_project = 'sms-unit-test'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'twilio-ruby', '~> 4.2'
  s.add_development_dependency 'lookout-clickatell', '~> 0.8'
  s.add_development_dependency 'pry'
end
