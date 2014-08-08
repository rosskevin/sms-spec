require 'spec_helper'

describe SmsSpec do
  include SmsSpec::Helpers

  before :each do
    SmsSpec::Data.clear_messages
  end

  describe "the twilio-ruby driver" do
    it "is assignable" do
      SmsSpec.driver = :"twilio-ruby"
    end

    it "intercepts calls to twilio's sms client" do
      account_sid = 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
      auth_token = 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'

      @client = Twilio::REST::Client.new account_sid, auth_token
      @client.account.messages.create(
        :from => '+14159341234',
        :to => '+16105557069',
        :body => 'Hey there!'
      )

      open_last_text_message_for("+16105557069")
      expect(current_text_message).to_not be_nil
    end

    it "allows for sid method calls on the account object" do
      account_sid = 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
      auth_token = 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'

      @client = Twilio::REST::Client.new account_sid, auth_token
      @client.account.messages.create(
        :from => '+14159341234',
        :to => '+16105557069',
        :body => 'Hey there!'
      )

      open_last_text_message_for("+16105557069")
      expect(current_text_message).to_not be_nil
      expect(@client.account).to respond_to(:sid)
      expect(@client.account.sid).to be(account_sid)
    end

    it "records the from number for a message" do
      account_sid = 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
      auth_token = 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'

      @client = Twilio::REST::Client.new account_sid, auth_token
      @client.account.messages.create(
        :from => '+14159341234',
        :to => '+16105557069',
        :body => 'Hey there!'
      )

      open_last_text_message_for("+16105557069")
      expect(current_text_message.from).to eq('+14159341234')
    end

  end
end
