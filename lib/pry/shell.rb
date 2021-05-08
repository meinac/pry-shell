# frozen_string_literal: true

require_relative "shell/version"
require_relative "shell/client"
require_relative "shell/logger"
require_relative "shell/registry"
require_relative "shell/server"
require_relative "shell/session"
require_relative "shell/io/base"
require_relative "shell/io/input"
require_relative "shell/io/output"
require_relative "shell/patches/object"
require_relative "shell/patches/repl"

class Pry
  class Shell
    DEFAULT_HOST = "localhost"
    DEFAULT_PORT = "8787"

    def self.run(host:, port:, auto_connect:)
      new(host, port, auto_connect).run
    end

    def initialize(host, port, auto_connect)
      @host = host
      @port = port
      @auto_connect = auto_connect
    end

    def run
      run_server
    end

    private

    attr_reader :host, :port, :auto_connect

    def run_server
      Server.new(host, port, auto_connect).run
    end
  end
end
