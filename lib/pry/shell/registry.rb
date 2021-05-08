# frozen_string_literal: true

class Pry
  class Shell
    class Registry
      def initialize
        @clients = []
      end

      def connect(name:, host:)
        Client.new(name, host).tap do |client|
          Logger.debug("New client connected - #{client}")

          @clients << client
        end
      end

      def request(*)
        true
      end

      def input
        IO::Input.new(Pry.config.input)
      end

      def output
        IO::Output.new(Pry.config.output)
      end
    end
  end
end
