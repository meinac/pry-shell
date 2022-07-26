# frozen_string_literal: true

require "readline"

class Pry
  class Shell
    module IO
      class Input < Base
        def readline(prompt)
          drb_thread

          wait_until_current

          string = object.readline(prompt, true)

          Command.execute(client, string)
        rescue
          drb_thread.kill

          nil
        end

        def drb_thread
          @drb_thread ||= Thread.current
        end

        # Assigns the `completion_proc` given by the
        # pry instance from the client slide.
        def completion_proc=(val)
          object.completion_proc = val if object.respond_to?(:completion_proc=)
        end

        def completion_proc
          object.completion_proc if object.respond_to?(:completion_proc)
        end
      end
    end
  end
end
