# frozen_string_literal: true

require "logger"
require "forwardable"
require "fileutils"

class Pry
  class Shell
    class Logger
      LOG_FOLDER = "tmp"

      class << self
        extend Forwardable

        def_delegators :logger, :unknown, :fatal, :error, :warn, :info, :debug

        private

        def logger
          @logger ||= ::Logger.new(log_file)
        end

        def log_file
          File.open(log_file_name, "w+").tap { |f| f.sync = true }
        end

        def log_file_name
          FileUtils.mkdir_p LOG_FOLDER

          File.join(LOG_FOLDER, "pry_shell.log")
        end
      end
    end
  end
end
