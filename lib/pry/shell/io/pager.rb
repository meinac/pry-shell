# frozen_string_literal: true

class Pry
  class Shell
    module IO
      class Pager < Pry::Pager
        class Output < Pry::Output
          def initialize(output) # rubocop:disable Lint/MissingSuper
            @output = output
            @color = Pry.config.color
          end
        end

        class Proxy < Base
          attr_reader :pager

          def initialize(output) # rubocop:disable Lint/MissingSuper
            output_proxy = Output.new(output)
            @pager = Pager.new(output_proxy)
          end

          def page(text)
            pager.page(text)
          end

          def open(&block)
            pager.open(&block)
          end
        end

        attr_reader :output

        def initialize(output) # rubocop:disable Lint/MissingSuper
          @output = output
        end

        def best_available
          if !Pry::Pager::SystemPager.available? || Pry::Helpers::Platform.jruby?
            Pry::Pager::SimplePager.new(output)
          else
            Pry::Pager::SystemPager.new(output)
          end
        end
      end
    end
  end
end
