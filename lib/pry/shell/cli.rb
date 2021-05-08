# frozen_string_literal: true

require "optparse"
require "pry/shell"

class Pry
  class Shell
    class CLI
      class << self
        def run
          options.parse!

          Shell.run(**config)

          join_drb_thread
        end

        private

        def config
          @config ||= {
            host: DEFAULT_HOST,
            port: DEFAULT_PORT,
            auto_connect: false
          }
        end

        def options # rubocop:disable Metrics/MethodLength
          @parser = OptionParser.new do |o|
            o.banner = "Usage: bundle exec pry-shell [options]"

            o.on "-h", "--host HOST", "Host name" do |arg|
              config[:host] = arg
            end

            o.on "-p", "--post PORT", "Port of the shell application" do |arg|
              config[:port] = arg
            end

            o.on "-a", "--auto-connect", "Connect automatically to the first Pry session" do
              config[:auto_connect] = true
            end

            o.on "-v", "--version", "Print version and exit" do
              puts "Pry-shell #{Pry::Shell::VERSION}"
              exit 0
            end
          end
        end

        def join_drb_thread
          DRb.thread.join
        rescue StandardError
          Process.kill("TERM", Process.pid)
        end
      end
    end
  end
end
