module Clickatell
  class API
    include SmsSpec::Helpers

    def self.authenticate(api_key, login, password)
      new(api_key, login, password)
    end

    def initialize(api_key, login, password)
      @api_key = api_key
      @login = login
      @password = password
    end

    def send_message(dest, body, opts={})
      from = opts[:from]
      add_message SmsSpec::Message.new(:number => dest, :from => from, :body => body)
    end
  end
end
