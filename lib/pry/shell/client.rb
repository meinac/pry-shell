# frozen_string_literal: true

require "drb"

class Pry
  class Shell
    class Client
      # As we are sending the instances of this class to the clients,
      # we should make sure the instance lives on the server.
      include DRb::DRbUndumped

      MAX_PROCESS_NAME = 50

      attr_reader :id

      def initialize(id, process_name, host, pid, location)
        @id = id
        @process_name = process_name
        @host = host
        @location = location
        @pid = pid
        @created_at = Time.now
      end

      def input
        @input ||= IO::Input.new(self, Pry.config.input)
      end

      def output
        @output ||= IO::Output.new(self, Pry.config.output)
      end

      def editor
        @editor ||= proc { |file, line| IO::Editor.open(file, line) }
      end

      def pager_proxy
        @pager_proxy ||= IO::Pager::Proxy.new(output)
      end

      def to_s
        "[#{pid}] \"#{humanized_process_name}\" @\"#{host}\" - #{full_location}"
      end

      def current?
        Shell.registry.current == self
      end

      private

      attr_reader :process_name, :host, :pid, :location, :created_at

      def full_location
        location.join(":")
      end

      def humanized_process_name
        process_name.length > MAX_PROCESS_NAME ? "#{process_name[0..50]}..." : process_name
      end
    end
  end
end
