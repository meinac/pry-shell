# frozen_string_literal: true

class Pry
  class Shell
    class UI
      class Configuration < Base
        HEADER = "PRY-SHELL Configuration"
        ITEMS = [
          { name: "Auto-connect", value: "auto_connect" },
          { name: "Go back to menu", value: "menu" }
        ].freeze
        ACTIONS = {
          "auto_connect" => -> { AutoConnect.draw! & draw! },
          "menu" => -> {}
        }.freeze

        class << self
          def draw_content
            selection = prompt.select("Select a configuration item to change it's value", ITEMS)

            ACTIONS[selection].call
          end

          def draw_footer; end
        end
      end
    end
  end
end
