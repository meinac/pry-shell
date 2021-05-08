# frozen_string_literal: true

class Pry
  class Shell
    module IO
      class Base
        include DRb::DRbUndumped

        def initialize(object)
          @object = object
        end

        private

        attr_reader :object
      end
    end
  end
end
