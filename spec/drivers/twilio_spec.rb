require 'spec_helper'

describe 'twilio-ruby' do
  include SmsSpec::Helpers
  SmsSpec.driver = :'twilio-ruby'

  before :each do
    SmsSpec::Data.clear_messages
  end

  context 'instantiation options' do

    before :each do
      @account_sid = 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
      @auth_token = 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
      @client = nil
    end

    it 'with two args' do
      @client = Twilio::REST::Client.new @account_sid, @auth_token
      expect(@client).to_not be_nil
    end

    it 'with config' do
      Twilio.configure do |config|
        config.account_sid = @account_sid
        config.auth_token = @auth_token
      end
      @client = Twilio::REST::Client.new
      expect(@client).to_not be_nil
    end
  end


  context 'using method_missing approach' do

    before do
      @account_sid = 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
      @auth_token = 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
      Twilio.configure do |config|
        config.account_sid = @account_sid
        config.auth_token = @auth_token
      end
      @client = Twilio::REST::Client.new
    end

    it 'intercepts calls to twilio sms client' do
      @client.messages.create(
          :from => '+14159341234',
          :to => '+16105557069',
          :body => 'Hey there!'
      )

      open_last_text_message_for('+16105557069')
      expect(current_text_message).to_not be_nil
    end

    it 'records the from number for a message' do
      @client.messages.create(
          :from => '+14159341234',
          :to => '+16105557069',
          :body => 'Hey there!'
      )

      open_last_text_message_for('+16105557069')
      expect(current_text_message.from).to eq('+14159341234')
    end
  end

  context 'using .account.* methods' do

    before do
      @account_sid = 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
      @auth_token = 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
      @client = Twilio::REST::Client.new @account_sid, @auth_token
    end

    it 'intercepts calls to twilio sms client' do
      @client.account.messages.create(
          :from => '+14159341234',
          :to => '+16105557069',
          :body => 'Hey there!'
      )

      open_last_text_message_for('+16105557069')
      expect(current_text_message).to_not be_nil
    end

    it 'records the from number for a message' do
      @client.account.messages.create(
          :from => '+14159341234',
          :to => '+16105557069',
          :body => 'Hey there!'
      )

      open_last_text_message_for('+16105557069')
      expect(current_text_message.from).to eq('+14159341234')
    end
  end
end
