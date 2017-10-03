require File.join(File.dirname(__FILE__), *%w[spec_helper])

describe SmsSpec::Helpers do
  include SmsSpec::Helpers

  before :each do
    SmsSpec::Data.clear_messages
  end

  describe ".messages" do
    describe "before any messages have been sent" do
      it "is empty" do
        expect(messages).to be_empty
      end
    end

    describe "after a message has been sent" do
      it "adds a message" do
        expect(lambda {
          add_message SmsSpec::Message.new :number => "5555555512", :body => "Hello there"
        }).to change(messages, :count).by(1)
      end
    end
  end

  describe ".set_current_number" do
    it "assigns the current number" do
      set_current_number "555551234"
      expect(current_number).to eql("555551234")
    end

    it 'does not format  phone numbers' do
      set_current_number '+1555551234'
      expect(current_number).to eql( '+1555551234')

      set_current_number '+1 (616) 555-2929'
      expect(current_number).to eql('+1 (616) 555-2929')
    end
  end

  describe ".clear_messages" do
    it "removes all messages" do
      add_message SmsSpec::Message.new :number => "5555555512", :body => "Hello there"
      add_message SmsSpec::Message.new :number => "5555555512", :body => "Hello there"
      add_message SmsSpec::Message.new :number => "5555555512", :body => "Hello there"

      expect(messages.count).to eql(3)
      clear_messages
      expect(messages.count).to eql(0)
    end
  end

  describe ".current_text_message" do
    describe "when there are not text messages yet" do
    before :each do
      SmsSpec::Data.clear_messages
    end

      it "returns nil" do
        expect(current_text_message).to be_nil
      end
    end

    describe "when there are messages" do
      let(:message1) { SmsSpec::Message.new :number => "5555555513", :body => "Hi" }
      let(:message2) { SmsSpec::Message.new :number => "5555555512", :body => "Hello there" }

      before do
        add_message message1
        add_message message2
      end

      describe "and no messages have been opened" do
        it "should be nil" do
          expect(current_text_message).to be_nil
        end
      end

      describe "and a message has been opened" do
        before do
          open_last_text_message_for("5555555513")
        end

        it "returns the last open text message" do
          expect(current_text_message).to eql(message1)

          open_last_text_message_for("5555555513")
          expect(current_text_message).to be_nil

          open_last_text_message_for("5555555512")
          expect(current_text_message).to eql(message2)
        end
      end
    end
  end

  describe ".twiml_message" do
    context "with defaults" do
      let(:message) {
        twiml_message("+16165559982", "Ahoy!")
      }

      it "modifies the From attribute" do
        expect(message["From"]).to eql("+16165559982")
      end

      it "Modifies the Body attribute" do
        expect(message["Body"]).to eql("Ahoy!")
      end
    end

    describe "Overriding options" do
      let(:message) {
        twiml_message("+16165559982", "Ahoy!", "ToZip" => "49506", "ToCity" => "Detroit")
      }

      it "overrides the specified attributes" do
        expect(message["ToZip"]).to eql("49506")
        expect(message["ToCity"]).to eql("Detroit")
        expect(message["Body"]).to eql("Ahoy!")
        expect(message["From"]).to eql("+16165559982")
      end
    end
  end

  describe ".clkatel_message" do
    context "with defaults" do
      let(:message) {
        clkatel_message("+16165559982", "Ahoy!")
      }

      it "modifies the From attribute" do
        expect(message["From"]).to eql("+16165559982")
      end

      it "Modifies the Body attribute" do
        expect(message["Text"]).to eql("Ahoy!")
      end
    end

    describe "Overriding options" do
      let(:message) {
        clkatel_message("+16165559982", "Ahoy!")
      }

      it "overrides the specified attributes" do
        expect(message["Text"]).to eql("Ahoy!")
        expect(message["From"]).to eql("+16165559982")
      end
    end
  end

end
