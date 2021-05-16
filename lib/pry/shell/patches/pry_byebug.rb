# frozen_string_literal: true

begin
  require "pry-byebug"
  require "pry-byebug/pry_ext"

  module Byebug
    class PryShellProcessor < PryProcessor
      def self.start
        Byebug.start
        Setting[:autolist] = false
        Context.processor = self
        Byebug.current_context.step_out(7, true)
      end

      def resume_pry
        new_binding = frame._binding

        run do
          if defined?(@pry) && @pry
            Pry::Shell::Repl.new(@pry, target: new_binding).start
          else
            @pry = Pry.start_without_pry_byebug(new_binding, Pry::Shell.active_shell_options)
          end
        end
      ensure
        Pry::Shell.clear_shell_options!
      end
    end
  end

  class Pry
    class Shell
      module Patches
        module PryByebug
          def start_with_pry_byebug(target = nil, options = {})
            return start_with_pry_shell(target) if Shell.active_shell_options

            super
          end

          def start_with_pry_shell(target)
            if Shell.active_shell_options[:with_byebug]
              ::Byebug::PryShellProcessor.start
            else
              start_without_pry_byebug(target, Shell.active_shell_options)
            end
          end
        end
      end
    end
  end

  Pry.singleton_class.prepend(Pry::Shell::Patches::PryByebug)
  Pry.singleton_class.alias_method(:start, :start_with_pry_byebug)
rescue LoadError # rubocop:disable Lint/SuppressedException
end
