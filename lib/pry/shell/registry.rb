# frozen_string_literal: true

require "drb"

class Pry
  class Shell
    class Registry
      include DRb::DRbUndumped

      attr_reader :auto_connect, :clients, :current

      def initialize(auto_connect)
        @auto_connect = auto_connect
        @clients = {}
      end

      def register(id:, name:, host:, location:)
        Client.new(id, name, host, location).tap do |client|
          Logger.debug("New client connected - #{client}")

          @clients[id] = client
          connect_to(client) if auto_connect
        end
      end

      def connect_to(client)
        # This thread is necessary because `UI::Session.draw!`
        # puts the main thread into sleep!
        Thread.start do
          UI::Session.draw!

          @current = client
        end
      end

      def disconnect(_client)
        @current = nil

        UI.restart!
      end

      def remove(client)
        @current = nil

        @clients.delete(client.id)

        UI.restart!
      end
    end
  end
end
