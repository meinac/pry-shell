# frozen_string_literal: true

require "socket"

class Pry
  class Shell
    class Session
      class << self
        def run(object, host:, port:)
          new(object, host, port).run
        end
      end

      def initialize(object, host, port)
        @object = object
        @host = host
        @port = port
      end

      def run
        registry.connect(id)

        setup if registry.request(id)
      end

      private

      attr_reader :object, :host, :port

      def registry
        @registry ||= begin
          DRb.start_service
          DRbObject.new(nil, uri)
        end
      end

      def id
        { name: $PROGRAM_NAME, host: Socket.gethostname }
      end

      def uri
        "druby://#{host}:#{port}"
      end

      def setup
        Pry.config.input = registry.input
        Pry.config.output = registry.output

        Pry.start(object)
      end
    end
  end
end
