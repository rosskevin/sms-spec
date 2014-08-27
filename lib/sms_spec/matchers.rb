module SmsSpec
  module Matchers

    RSpec::Matchers.define :have_text_messages do
      match do |mobile_device|
        mobile_device.messages.count > 0
      end

      if Gem::Version.new(RSpec::Core::Version::STRING) >= Gem::Version.new("3.0.0.beta2")
        failure_message do |mobile_device|
          "expected the mobile device '#{mobile_device.number}' to have text messages but it did not"
        end

        failure_message_when_negated do |mobile_device|
          "expected the mobile device '#{mobile_device.number}' to have no text messages but it did"
        end
      else
        failure_message_for_should do |mobile_device|
          "expected the mobile device '#{mobile_device.number}' to have text messages but it did not"
        end

        failure_message_for_should_not do |mobile_device|
          "expected the mobile device '#{mobile_device.number}' to have no text messages but it did"
        end
      end
    end

    RSpec::Matchers.define :have_body do |expected_body|
      match do |message|
        message.body == expected_body
      end
    end

    RSpec::Matchers.define :have_body_like do |expected_body|
      match do |message|
        message.body.match(expected_body)
      end
    end

  end
end
