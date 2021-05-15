# frozen_string_literal: true

require "drb"

class Pry
  class Shell
    class Server
      class << self
        def run
          Logger.info("Running Drb server on '#{uri}'")

          DRb.start_service(uri, Shell.registry)
        end

        private

        def uri
          "druby://#{Shell.configuration.host}:#{Shell.configuration.port}"
        end
      end
    end
  end
end
