# frozen_string_literal: true

class Pry
  class Shell
    class UI
      class Session < Base
        HEADER = "PRY-SHELL"

        class << self
          def draw!
            stop_main_ui!
            clear!
            draw_header
            draw_seperator
          end
        end
      end
    end
  end
end
