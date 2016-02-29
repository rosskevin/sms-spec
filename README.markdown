# SMS Spec

[![Build Status](https://travis-ci.org/rosskevin/sms-spec.svg)](https://travis-ci.org/rosskevin/sms-spec)
[![Code Climate](https://codeclimate.com/github/rosskevin/sms-spec/badges/gpa.svg)](https://codeclimate.com/github/rosskevin/sms-spec)

An RSpec DSL and Cucumber steps to test SMS interactions with your
Ruby on Rails application.

Currently this gem only supports testing SMS messaging using the
[twilio-ruby](https://github.com/twilio/twilio-ruby) and
[lookout-clickatell](https://github.com/lookout/clickatell) gem.

##Setup
Add the sms-spec gem to `Gemfile`:

```ruby
group :test do
  gem 'sms-spec'
end
```

## RSpec
Configure a driver and include helper and matcher methods in the `spec_helper.rb`:

```ruby
require 'sms_spec'

Spec::Runner.configure do |config|
  config.include(SmsSpec::Helpers)
  config.include(SmsSpec::Matchers)
end

SmsSpec.driver = :twilio-ruby #this can be any available sms-spec driver
```

## Cucumber
Add the following to `env.rb`:

```ruby
require 'sms_spec'
require 'sms_spec/cucumber'
```

This loads the sms_spec RSpec helpers into your cucumber wold. Then,
run the following to generate the text_messsage_steps.rb file:

```ruby
rails generate sms_spec:steps
```
