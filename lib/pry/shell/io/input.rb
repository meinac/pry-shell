# frozen_string_literal: true

require "readline"

class Pry
  class Shell
    module IO
      class Input < Base
        def readline(prompt)
          object.readline(prompt, true)
        end
      end
    end
  end
end
