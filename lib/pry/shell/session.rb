# frozen_string_literal: true

require "socket"
require "securerandom"

require_relative "patches/object"
require_relative "patches/pager"
require_relative "patches/pry_byebug"
require_relative "patches/rack_timeout"
require_relative "repl"

class Pry
  class Shell
    class Session
      class << self
        def run(object, host:, port:, with_byebug:)
          new(object, host, port, with_byebug).run
        end
      end

      def initialize(object, host, port, with_byebug)
        @object = object
        @host = host
        @port = port
        @with_byebug = with_byebug
      end

      def run
        Shell.active_shell_options = pry_options

        Pry.start(pry_options.merge(target: object))
      rescue DRb::DRbConnError
        puts "DRb connection failed!"
      ensure
        # Since we run `Byebug.current_context.step_out` this ensure
        # block already runs and clears the options which are necessary
        # to setup the Byebug.
        # We are clearing this options in `PryShellProcessor` to ensure
        # they do not leak.
        unless enable_byebug?
          pry_options[:remove_connection].call

          Shell.clear_shell_options!
        end
      end

      private

      attr_reader :object, :host, :port, :with_byebug

      def pry_options
        {
          remove_connection: -> { registry.remove(client) },
          enable_byebug?: enable_byebug?,
          driver: Pry::Shell::Repl,
          pager: false,
          input: client.input,
          output: client.output,
          editor: client.editor,
          pager_proxy: client.pager_proxy # This is our own config
        }
      end

      # Setting the `with_byebug` option as `true` is not enough as the
      # `pry-byebug` gem can be missing which we are currently depending on.
      def enable_byebug?
        with_byebug && defined?(::Byebug::PryShellProcessor)
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
        {
          name: $PROGRAM_NAME,
          host: Socket.gethostname,
          pid: Process.pid,
          location: object.source_location
        }
      end

      def uri
        "druby://#{host}:#{port}"
      end
    end
  end
end
