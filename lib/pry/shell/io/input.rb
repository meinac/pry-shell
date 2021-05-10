# frozen_string_literal: true

require "readline"

class Pry
  class Shell
    module IO
      class Input < Base
        def readline(prompt)
          wait_until_current

          string = object.readline(prompt, true)

          Command.execute(client, string)
        end
      end
    end
  end
end
