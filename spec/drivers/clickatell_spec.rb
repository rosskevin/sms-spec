require 'spec_helper'

describe SmsSpec do
  include SmsSpec::Helpers

  before do
    require 'clickatell'
    SmsSpec.driver = :"clickatell"
    @to_number   = '27999900001' # TEST NUMBER
    @from_number = '27999900005' # TEST NUMBER
    @api = Clickatell::API.authenticate(
      ENV["CLICKATELL_API_KEY"],
      ENV["CLICKATELL_LOGIN"],
      ENV["CLICKATELL_PASSWORD"]
    )

    SmsSpec::Data.clear_messages
  end

  describe "the clickatell driver" do
    it "captures the outgoing message for testing" do
      @api.send_message(@to_number, 'Hello from clickatell')
      open_last_text_message_for(@to_number)

      expect(current_text_message).to have_body("Hello from clickatell")
      expect(current_text_message.number).to eql(@to_number)
      expect(current_text_message.from).to be_nil
    end

  end
end

