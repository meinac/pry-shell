# frozen_string_literal: true

class Pry
  class Shell
    class UI
      class Menu < Base
        HEADER = "PRY-SHELL Main Menu"
        ITEMS = [
          { name: "1) Available sessions", value: "list" },
          { name: "2) About pry-shell", value: "about" },
          { name: "3) Quit", value: "quit" }
        ].freeze
        MENU_ACTIONS = {
          "list" => -> { List.draw! },
          "about" => -> { About.draw! },
          "quit" => -> { clear! && exit(0) }
        }.freeze

        class << self
          def draw_content
            selection = prompt.select("Select a menu item", ITEMS)

            switch_to(selection)
          end

          # Override this to remove "press any key" prompt
          def draw_footer; end

          def switch_to(selected_ui)
            MENU_ACTIONS[selected_ui].call
          end
        end
      end
    end
  end
end
