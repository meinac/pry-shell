# frozen_string_literal: true

class Pry
  class Shell
    module IO
      class Base
        include DRb::DRbUndumped

        def initialize(client, object)
          @client = client
          @object = object
        end

        private

        attr_reader :client, :object

        def wait_until_current
          sleep(0.5) until current?
        end

        def current?
          client.current?
        end
      end
    end
  end
end
