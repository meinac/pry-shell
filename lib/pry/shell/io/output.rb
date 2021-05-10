# frozen_string_literal: true

class Pry
  class Shell
    module IO
      class Output < Base
        def puts(data)
          wait_until_current

          object.puts data
        end

        def print(data)
          wait_until_current

          object.print data
        end

        def printf(data)
          wait_until_current

          object.printf data
        end

        def write(data)
          wait_until_current

          object.printf data
        end

        def <<(data)
          wait_until_current

          object << data
          self
        end
      end
    end
  end
end
