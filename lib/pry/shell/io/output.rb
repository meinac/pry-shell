# frozen_string_literal: true

class Pry
  class Shell
    module IO
      class Output < Base
        extend Forwardable

        def_delegators :object, :puts, :print, :printf, :write

        def <<(data)
          object << data
          self
        end
      end
    end
  end
end
