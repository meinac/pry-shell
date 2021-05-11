# frozen_string_literal: true

require "socket"
require "securerandom"

require_relative "patches/object"
require_relative "patches/pry_byebug"
require_relative "patches/rack_timeout"
require_relative "repl"

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
        Shell.active_shell_options = pry_options

        Pry.start(object, pry_options)
      rescue DRb::DRbConnError
        puts "DRb connection failed!"
      ensure
        Shell.active_shell_options = nil
      end

      private

      attr_reader :object, :host, :port

      def pry_options
        {
          driver: Pry::Shell::Repl,
          pager: false,
          input: client.input,
          output: client.output
        }
      end

      def client
        @client ||= registry.register(id: id, **attributes)
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
        { name: $PROGRAM_NAME, host: Socket.gethostname, location: object.source_location }
      end

      def uri
        "druby://#{host}:#{port}"
      end
    end
  end
end
