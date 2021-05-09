# frozen_string_literal: true

require "socket"
require "securerandom"

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
        setup

        Pry.start(object)
      end

      private

      attr_reader :object, :host, :port

      def client
        @client ||= registry.connect(id: id, **attributes)
      end

      def registry
        @registry ||= begin
          DRb.start_service
          DRbObject.new(nil, uri)
        end
      end

      def id
        @id ||= SecureRandom.uuid
      end

      def attributes
        { name: $PROGRAM_NAME, host: Socket.gethostname }
      end

      def uri
        "druby://#{host}:#{port}"
      end

      def setup
        Pry.config.input = client.input
        Pry.config.output = client.output
      end
    end
  end
end
