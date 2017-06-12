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
  gem "sms-spec"
end
```

## RSpec
Configure a driver and include helper and matcher methods in the `spec_helper.rb`:

```ruby
require "sms_spec"

Spec::Runner.configure do |config|
  config.include(SmsSpec::Helpers)
  config.include(SmsSpec::Matchers)
end

SmsSpec.driver = :"twilio-ruby" #this can be any available sms-spec driver
```

### Usage

```ruby
describe "alarm notifications" do
  subject(:job) { AlarmNotificationJob.new }

  context "via sms" do
    let!(:subscription) { FactoryGirl.create :alarm_subscription_sms }

    it "delivers an alarm notification" do
      job.perform

      open_last_text_message_for(subscription.recipient)
      expect(current_text_message.body).to eq("Yo")
    end
  end
end
```

## Cucumber
Add the following to `env.rb`:

```ruby
require "sms_spec"
require "sms_spec/cucumber"
```

This loads the `sms_spec` RSpec helpers into your cucumber wold. Then,
run the following to generate the `text_messsage_steps.rb` file:

```ruby
rails generate sms_spec:steps
```

### Usage

```ruby
Feature: Registering via SMS

  In order to use our application
  As a user
  I want to be able to register with any mobile phone

  Scenario: A user submits their phone number for registration
    Given I am on the homepage
    And I fill in "What is your phone number?" with "6165552345"
    When I press "Register"

    Then I should see "Thank You"
    And "6165552345" opens the text message
    And I should see "Thank you for registering. To confirm your subscript reply YES." in the text message body
```
