require 'rspec/core'
require 'rspec/expectations'
require 'rspec/mocks'
require 'sms_spec/version'
require 'sms_spec/helpers'
require 'sms_spec/data'
require 'sms_spec/message'
require 'sms_spec/mobile_device'
require 'sms_spec/matchers'

module SmsSpec
  def self.driver=(driver_sym)
    require "sms_spec/drivers/#{driver_sym.to_s}"
  end
end
