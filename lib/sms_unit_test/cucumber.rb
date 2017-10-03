After do
  SmsUnitTest::Data.clear_messages
end

World(SmsUnitTest::Helpers)
World(SmsUnitTest::Matchers)
