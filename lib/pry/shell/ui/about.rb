# frozen_string_literal: true

class Pry
  class Shell
    class UI
      class About < Base
        HEADER = "PRY-SHELL About"
        CONTENT = <<~MARKDOWN
          pry-shell version "#{VERSION}"

          Pry-shell provides you a standalone shell for accessing multiple `pry` sessions running on different processes.
          You can switch between sessions by going back to the menu using the "\\m" command.

          Written by Mehmet Emin INAC.
        MARKDOWN
      end
    end
  end
end
