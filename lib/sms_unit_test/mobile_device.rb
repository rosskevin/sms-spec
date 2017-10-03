module SmsUnitTest
  class MobileDevice

    def initialize(number)
      @number = number
    end

    def messages
      SmsUnitTest::Data.messages.select {|d| d.number == @number}
    end
  end
end