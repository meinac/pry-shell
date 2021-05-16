# frozen_string_literal: true

class Pry
  class Shell
    module Patches
      module Object
        def pry_shell(host: DEFAULT_HOST, port: DEFAULT_PORT, with_byebug: false)
          Session.run(self, host: host, port: port, with_byebug: with_byebug)
        end
      end
    end
  end
end

Object.prepend(Pry::Shell::Patches::Object)
