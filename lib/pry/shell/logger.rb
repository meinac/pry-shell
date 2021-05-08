# frozen_string_literal: true

require "logger"
require "forwardable"

class Pry
  class Shell
    class Logger
      class << self
        extend Forwardable

        def_delegators :logger, :unknown, :fatal, :error, :warn, :info, :debug

        private

        def logger
          @logger ||= ::Logger.new($stdout)
        end
      end
    end
  end
end
