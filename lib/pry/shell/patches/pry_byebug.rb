# frozen_string_literal: true

begin
  require "pry-byebug"
  require "pry-byebug/pry_ext"

  module Byebug
    class PryShellProcessor < PryProcessor
      class << self
        def start
          Byebug.start
          Setting[:autolist] = false
          Context.processor = self
          Byebug.current_context.step_out(7, true)
          at_exit { teardown! }
        end

        private

        def teardown!
          Pry::Shell.remove_active_connection!
          Pry::Shell.clear_shell_options!
        end
      end

      def resume_pry
        run do
          pry_started? ? start_new_pry_repl : start_new_pry_session
        end
      rescue DRb::DRbConnError
        puts "DRb connection failed!"
      end

      private

      def pry_started?
        defined?(@pry) && @pry
      end

      def start_new_pry_session
        @pry = Pry.start_without_pry_byebug(frame._binding, Pry::Shell.active_shell_options)
      end

      def start_new_pry_repl
        Pry::Shell::Repl.new(@pry, target: frame._binding).start
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
            if Shell.active_shell_options[:enable_byebug?]
              ::Byebug::PryShellProcessor.start
            else
              start_without_pry_byebug(target, Shell.active_shell_options)
            end
          end
        end

        module PryProcessor
          def start
            super

            # We should step out one more frame as we are
            # prepending another module to the hierarchy
            ::Byebug.current_context.step_out(5, true)
          end
        end
      end
    end
  end

  Pry.singleton_class.prepend(Pry::Shell::Patches::PryByebug)
  Pry.singleton_class.alias_method(:start, :start_with_pry_byebug)

  Byebug::PryProcessor.singleton_class.prepend(Pry::Shell::Patches::PryProcessor)
rescue LoadError # rubocop:disable Lint/SuppressedException
end
