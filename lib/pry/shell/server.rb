# frozen_string_literal: true

require "drb"

class Pry
  class Shell
    class Server
      def initialize(host, port, auto_connect)
        @host = host
        @port = port
        @auto_connect = auto_connect
      end

      def run
        Logger.info("Running Drb server on '#{uri}'")

        DRb.start_service(uri, registry)
      end

      private

      attr_reader :host, :port, :auto_connect

      def uri
        "druby://#{host}:#{port}"
      end

      def registry
        Registry.new
      end
    end
  end
end
