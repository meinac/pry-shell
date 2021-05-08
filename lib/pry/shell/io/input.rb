# frozen_string_literal: true

require "readline"

class Pry
  class Shell
    module IO
      class Input < Base
        def readline(prompt)
          if Readline == object
            object.readline(prompt, true)
          elsif object.method(:readline).arity == 1
            object.readline(prompt)
          else
            $stdout.print prompt
            object.readline
          end
        end
      end
    end
  end
end
