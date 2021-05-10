# frozen_string_literal: true

require "tty-markdown"
require "tty-prompt"

class Pry
  class Shell
    class UI
      class Base
        SEPERATOR = "---"

        class << self
          def draw!
            clear!
            draw_header
            draw_seperator
            draw_content
            draw_seperator
            draw_footer
          end

          def stop_main_ui!
            UI.stop!
          end

          def clear!
            system("clear") || system("cls")
          end

          private

          def draw_header
            print_markdown(header)
          end

          def draw_seperator
            print_markdown(SEPERATOR)
          end

          def draw_content
            print_markdown(content)
          end

          def draw_footer
            return_menu_prompt
          end

          def header
            "##{const_get(:HEADER)}"
          end

          def content
            const_get(:CONTENT)
          end

          def prompt
            @prompt ||= TTY::Prompt.new
          end

          def print_markdown(text)
            puts TTY::Markdown.parse(text)
          end

          def return_menu_prompt
            prompt.keypress("Press any key to return to the menu...")

            Menu.draw!
          end
        end
      end
    end
  end
end
