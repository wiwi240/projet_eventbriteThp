ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
begin
  require "minitest"
  if defined?(Minitest) && Minitest.const_defined?(:Runnable)
    begin
      um = Minitest::Runnable.instance_method(:run)
      if um.arity >= 0 && um.arity < 3
        Minitest::Runnable.class_eval do
          alias_method :__run_without_compat, :run
          define_method(:run) do |*args, &block|
            __run_without_compat(*args[0, 2], &block)
          end
        end
      end
    rescue NameError, NoMethodError
      # If Runnable or run isn't defined yet, ignore — worst case shim in test_helper will still try
    end
  end
rescue LoadError
  # minitest might not be installed at boot time; ignore
end

require "bootsnap/setup" # Speed up boot time by caching expensive operations.
