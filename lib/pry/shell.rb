# frozen_string_literal: true

require_relative "shell/version"
require_relative "shell/client"
require_relative "shell/command"
require_relative "shell/configuration"
require_relative "shell/logger"
require_relative "shell/registry"
require_relative "shell/server"
require_relative "shell/session"
require_relative "shell/io/base"
require_relative "shell/io/editor"
require_relative "shell/io/input"
require_relative "shell/io/output"
require_relative "shell/io/pager"
require_relative "shell/ui"
require_relative "shell/ui/base"
require_relative "shell/ui/about"
require_relative "shell/ui/configuration"
require_relative "shell/ui/configuration/auto_connect"
require_relative "shell/ui/list"
require_relative "shell/ui/menu"
require_relative "shell/ui/session"

class Pry
  class Shell
    DEFAULT_HOST = "localhost"
    DEFAULT_PORT = "1881"

    class << self
      def run
        run_server
        draw_ui
      rescue TTY::Reader::InputInterrupt, Interrupt
        exit
      end

      def active_shell_options(thread: Thread.current)
        thread[:active_shell_options]
      end

      def active_shell_options=(value)
        Thread.current[:active_shell_options] = value
      end

      def clear_shell_options!
        self.active_shell_options = nil
      end

      def remove_active_connection!
        active_shell_options&.fetch(:remove_connection)&.call
      end

      def configuration
        @configuration ||= Configuration.new
      end

      def registry
        @registry ||= Registry.new
      end

      private

      def run_server
        Server.run
      end

      def draw_ui
        UI.draw!
      end
    end
  end
end
