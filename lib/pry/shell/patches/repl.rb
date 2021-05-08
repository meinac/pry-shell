# frozen_string_literal: true

require "pry"

class Pry
  class Shell
    module Patches
      module Repl
        def read_line(current_prompt)
          handle_read_errors do
            setup_auto_completion
            read_command(current_prompt)
          end
        end

        private

        def setup_auto_completion
          if coolline_available?
            input.completion_proc = proc do |cool|
              completions = @pry.complete cool.completed_word
              completions.compact
            end
          elsif input.respond_to? :completion_proc=
            input.completion_proc = proc do |inp|
              @pry.complete inp
            end
          end
        end

        def read_command(current_prompt)
          if readline_available?
            set_readline_output
            input_readline(current_prompt, false) # false since we'll add it manually
          elsif coolline_available?
            input_readline(current_prompt)
          else
            input_readline(current_prompt)
          end
        end
      end
    end
  end
end

Pry::REPL.prepend(Pry::Shell::Patches::Repl)
