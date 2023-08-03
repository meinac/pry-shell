# frozen_string_literal: true

class Pry
  class Shell
    module Patches
      module RackTimeout
        def initialize(&on_timeout)
          timeout_handler = on_timeout || ON_TIMEOUT

          @on_timeout = -> (thread) { Shell.active_shell_options(thread: thread) || timeout_handler.call(thread) } # Do not raise timeout error if the shell session is active
          @scheduler  = Rack::Timeout::Scheduler.singleton
        end
      end
    end
  end
end

begin
  require "rack/timeout/base"

  Rack::Timeout::Scheduler::Timeout.prepend(Pry::Shell::Patches::RackTimeout)
rescue LoadError # rubocop:disable Lint/SuppressedException
end
