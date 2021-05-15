# frozen_string_literal: true

require "optparse"
require "pry/shell"

class Pry
  class Shell
    class CLI
      class << self
        def run
          options.parse!

          Shell.run

          join_drb_thread
        end

        private

        def options # rubocop:disable Metrics/MethodLength
          @parser = OptionParser.new do |o|
            o.banner = "Usage: bundle exec pry-shell [options]"

            o.on "-h", "--host HOST", "Host name" do |arg|
              Shell.configuration.host = arg
            end

            o.on "-p", "--post PORT", "Port of the shell application" do |arg|
              Shell.configuration.port = arg
            end

            o.on "-a", "--auto-connect", "Connect automatically to the first Pry session" do
              Shell.configuration.auto_connect = true
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
