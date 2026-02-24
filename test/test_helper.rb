ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
begin
  require "minitest"
  # Compatibility shim: some versions of Rails call Minitest::Runnable.run
  # with 3 arguments while the installed Minitest expects 1..2. Wrap the
  # method to accept variable args and delegate to the original signature.
  if Minitest::Runnable.instance_method(:run).arity >= 0 && Minitest::Runnable.instance_method(:run).arity < 3
    Minitest::Runnable.class_eval do
      alias_method :__run_without_compat, :run
      define_method(:run) do |*args, &block|
        __run_without_compat(*args[0, 2], &block)
      end
    end
  end
rescue LoadError
  # minitest not available at this point; let require "rails/test_help" handle it
end

require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
