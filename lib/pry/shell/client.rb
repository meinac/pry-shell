# frozen_string_literal: true

require "drb"

class Pry
  class Shell
    class Client
      # As we are sending the instances of this class to the clients,
      # we should make sure the instance lives on the server.
      include DRb::DRbUndumped

      def initialize(id, process_name, host)
        @id = id
        @process_name = process_name
        @host = host
      end

      def input
        @input ||= IO::Input.new(Pry.config.input)
      end

      def output
        @output ||= IO::Output.new(Pry.config.output)
      end

      def to_s
        "#{process_name} @#{host}"
      end

      private

      attr_reader :process_name, :host
    end
  end
end
