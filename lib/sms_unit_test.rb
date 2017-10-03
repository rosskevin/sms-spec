require 'rspec/core'
require 'rspec/expectations'
require 'rspec/mocks'
require 'sms_unit_test/version'
require 'sms_unit_test/helpers'
require 'sms_unit_test/data'
require 'sms_unit_test/message'
require 'sms_unit_test/mobile_device'
require 'sms_unit_test/matchers'

module SmsUnitTest
  def self.driver=(driver_sym)
    require "sms_unit_test/drivers/#{driver_sym.to_s}"
  end
end
