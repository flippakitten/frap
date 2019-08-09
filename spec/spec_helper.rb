require "bundler/setup"
require "frap"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    system('git clone https://github.com/flippakitten/frap_test_suite_app.git')
  end

  config.after(:suite) do
    if Dir.pwd.include?('test_app_create_spec') || Dir.pwd.include?('frap_test_suite_app')
      raise StandardError.new("Currently in #{Dir.pwd} directory and you shouldn't be, check")
    end

    FileUtils.rm_rf("#{Dir.pwd}/frap_test_suite_app")
    FileUtils.rm_rf("#{Dir.pwd}/test_app_create_spec")
  end

  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end
end
