# frozen_string_literal: true

class Pry
  class Shell
    module Patches
      module Pager
        def pager
          config.pager_proxy || super
        end
      end
    end
  end
end

Pry.prepend(Pry::Shell::Patches::Pager)
