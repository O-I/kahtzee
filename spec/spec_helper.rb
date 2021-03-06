RSpec.configure do |config|
  # Use color not only in STDOUT but also in pagers and files
  config.tty = true
  # Use the specified formatter
  config.formatter = :documentation
  # continue testing through failures
  config.fail_fast = false
end