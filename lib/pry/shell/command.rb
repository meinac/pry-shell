# frozen_string_literal: true

class Pry
  class Shell
    class Command
      EXIT_COMMANDS = %w[exit !!!].freeze
      DISC_COMMAND = "\\m"

      def self.execute(client, string)
        case string
        when *EXIT_COMMANDS
          Shell.registry.remove(client) && string
        when DISC_COMMAND
          Shell.registry.disconnect(client) && ""
        else
          string
        end
      end
    end
  end
end
