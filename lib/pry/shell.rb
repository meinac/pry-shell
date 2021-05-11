# frozen_string_literal: true

require_relative "shell/version"
require_relative "shell/client"
require_relative "shell/command"
require_relative "shell/logger"
require_relative "shell/registry"
require_relative "shell/server"
require_relative "shell/session"
require_relative "shell/io/base"
require_relative "shell/io/input"
require_relative "shell/io/output"
require_relative "shell/patches/object"
require_relative "shell/ui"
require_relative "shell/ui/base"
require_relative "shell/ui/about"
require_relative "shell/ui/list"
require_relative "shell/ui/menu"
require_relative "shell/ui/session"

class Pry
  class Shell
    DEFAULT_HOST = "localhost"
    DEFAULT_PORT = "8787"

    class << self
      attr_reader :registry

      def run(host:, port:, auto_connect:)
        @registry = Registry.new(auto_connect)

        new(host, port, registry).run
      end
    end

    def initialize(host, port, registry)
      @host = host
      @port = port
      @registry = registry
    end

    def run
      run_server
      draw_ui
    end

    private

    attr_reader :host, :port, :registry

    def run_server
      Server.new(host, port, registry).run
    end

    def draw_ui
      UI.draw!
    end
  end
end
