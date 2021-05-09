# frozen_string_literal: true

class Pry
  class Shell
    class Registry
      def initialize
        @clients = {}
      end

      def connect(id:, name:, host:)
        Client.new(id, name, host).tap do |client|
          Logger.debug("New client connected - #{client}")

          @clients[id] = client
        end
      end
    end
  end
end
