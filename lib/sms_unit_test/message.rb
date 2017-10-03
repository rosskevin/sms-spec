module SmsUnitTest
  class Message
    attr_accessor :number
    attr_accessor :body
    attr_accessor :from

    def initialize(opts = {})
      @number = opts[:number]
      @body = opts[:body]
      @from = opts[:from]
    end
  end
end
