# SMS Spec

An RSpec DSL and Cucumber steps to test SMS interactions with your
Ruby on Rails application.

Currently this gem only supports testing SMS messageing using the
[twilio-ruby](https://github.com/twilio/twilio-ruby) and
[lookout-clickatell](https://github.com/lookout/clickatell) gem.

##Setup
Add the sms-spec gem to your Gemfile:
<pre>
group :test do
  gem 'sms-spec'
end
</pre>

## RSpec
In your spec\_helper.rb file configure a driver and include helper and matcher methods.

<pre>
require 'sms\_spec'

Spec::Runner.configure do |config|
  config.include(SmsSpec::Helpers)
  config.include(SmsSpec::Matchers)
end

SmsSpec.driver = :twilio-ruby #this can be any available sms-spec driver
</pre>

## Cucumber
Add the folloing to you env.rb file:

<pre>
require 'sms\_spec'
require 'sms\_spec/cucumber'
</pre>

This loads the sms\_spec RSpec helpers into your cucumber wold. Then,
run the following to generate the text\_messsage\_steps.rb file:

<pre>
rails generate sms_spec:steps
</pre>
