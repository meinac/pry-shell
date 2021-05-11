# frozen_string_literal: true

class Pry
  class Shell
    module Patches
      module PryByebug
        def start_with_pry_byebug(target, options = {})
          return start_without_pry_byebug(target, options) if Thread.current[:pry_shell_active?]

          super
        end
      end
    end
  end
end

begin
  require "pry-byebug"
  require "pry-byebug/pry_ext"

  Pry.singleton_class.prepend(Pry::Shell::Patches::PryByebug)
  Pry.singleton_class.alias_method(:start, :start_with_pry_byebug)
rescue LoadError # rubocop:disable Lint/SuppressedException
end
