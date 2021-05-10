# frozen_string_literal: true

require "drb"

class Pry
  class Shell
    class Server
      def initialize(host, port, registry)
        @host = host
        @port = port
        @registry = registry
      end

      def run
        Logger.info("Running Drb server on '#{uri}'")

        DRb.start_service(uri, registry)
      end

      private

      attr_reader :host, :port, :registry

      def uri
        "druby://#{host}:#{port}"
      end
    end
  end
end
