# frozen_string_literal: true

class Pry
  class Shell
    class UI
      class List < Base
        HEADER = "PRY-SHELL Sessions"
        EMPTY_LIST = "No session available!"
        TO_MENU_ITEM = { name: "Go back to menu", value: "menu" }.freeze

        class << self
          def draw_content
            clients.empty? ? draw_empty_list : draw_list
          end

          private

          def draw_empty_list
            print_markdown(EMPTY_LIST)
          end

          def draw_list
            id = prompt.select("Select session to connect", select_values)

            id == "menu" ? to_menu : connect_to(id)
          end

          def select_values
            clients.map { |id, client| { name: client.to_s, value: id } }
                   .push(TO_MENU_ITEM)
          end

          def to_menu
            Menu.draw!
          end

          def connect_to(id)
            Shell.registry.connect_to(clients[id])
          end

          def clients
            Shell.registry.clients
          end
        end
      end
    end
  end
end
