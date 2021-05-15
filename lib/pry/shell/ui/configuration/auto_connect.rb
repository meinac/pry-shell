# frozen_string_literal: true

class Pry
  class Shell
    class UI
      class Configuration
        class AutoConnect < Base
          class << self
            def draw!
              Shell.configuration.auto_connect = show_prompt
            end

            private

            def show_prompt
              prompt.select("Accept connections automatically?", cycle: true) do |config|
                config.default default_value

                config.choice "yes", true
                config.choice "no", false
              end
            end

            def default_value
              Shell.configuration.auto_connect ? "yes" : "no"
            end
          end
        end
      end
    end
  end
end
