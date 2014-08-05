module Twilio
  module REST
    class Client

      def initialize(account_sid, auth_token)
        $account_sid = account_sid
      end

      class Messages
        include SmsSpec::Helpers

        def create(opts={})
          to = opts[:to]
          body = opts[:body]
          from = opts[:from]
          add_message SmsSpec::Message.new(:number => to, :from => from, :body => body)
        end
      end

      class Account
        def sms
          Sms.new
        end

        def messages
          Messages.new
        end
      end

      def account
        account = Account.new
        account.class.send(:define_method, :sid, lambda { $account_sid })
        account
      end
    end
  end
end
