begin
  require 'twilio-ruby'
rescue LoadError
  puts 'WARNING: Twilio is not loaded properly. Ensure to add "twilio-ruby" to your Gemfile before using this driver'
end

module Twilio
  extend SingleForwardable

  def_delegators :configuration, :account_sid, :auth_token

  ##
  # Pre-configure with account SID and auth token so that you don't need to
  # pass them to various initializers each time.
  def self.configure(&block)
    yield configuration
  end

  ##
  # Returns an existing or instantiates a new configuration object.
  def self.configuration
    @configuration ||= Util::Configuration.new
  end
  private_class_method :configuration

  module REST
    class Client

      def initialize(*args)
        # mimic the primary class's #initialize.
        options = args.last.is_a?(Hash) ? args.pop : {}
        @config = options #DEFAULTS.merge! options

        @account_sid = args[0] || Twilio.account_sid
        @auth_token = args[1] || Twilio.auth_token
        if @account_sid.nil? || @auth_token.nil?
          raise ArgumentError, 'Account SID and auth token are required'
        end
      end

      class Messages
        include SmsUnitTest::Helpers

        def create(opts={})
          to = opts[:to]
          body = opts[:body]
          from = opts[:from]
          add_message SmsUnitTest::Message.new(:number => to, :from => from, :body => body)
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
      end


      ## Mirror method_missing approach
      ##
      # Delegate account methods from the client. This saves having to call
      # <tt>client.account</tt> every time for resources on the default
      # account.
      def method_missing(method_name, *args, &block)
        if account.respond_to?(method_name)
          account.send(method_name, *args, &block)
        else
          super
        end
      end

      def respond_to?(method_name, include_private=false)
        if account.respond_to?(method_name, include_private)
          true
        else
          super
        end
      end
    end
  end
end
