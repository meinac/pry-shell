# frozen_string_literal: true

class Pry
  class Shell
    module Patches
      module RackTimeout
        def initialize(&on_timeout)
          @on_timeout = -> (thread) { Shell.active_shell_options(thread: thread) || on_timeout || ON_TIMEOUT }
          @scheduler  = Rack::Timeout::Scheduler.singleton
        end
      end
    end
  end
end

begin
  require "rack-timeout"

  Rack::Timeout::Scheduler::Timeout.prepend(Pry::Shell::Patches::RackTimeout)
rescue LoadError # rubocop:disable Lint/SuppressedException
end
