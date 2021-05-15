# frozen_string_literal: true

class Pry
  class Shell
    class UI
      StopMainUI = Class.new(StandardError)

      class << self
        def draw!
          UI::Menu.draw!
          draw!
        rescue StopMainUI
          sleep
          draw!
        end

        def stop!
          Thread.main.raise StopMainUI.new
        end

        def restart!
          Thread.main.wakeup
        end
      end
    end
  end
end
