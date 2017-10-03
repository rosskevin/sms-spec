class SmsUnitTestGenerator < Rails::Generator::Base
  def manifest
    m.directory 'features/step_definitions'
    m.file 'sms_steps.rb', 'features/step_definitions/sms_steps.rb'
  end

  protected

  def banner
    "Usage: #{0} sms_unit_test"
  end
end
