# frozen_string_literal: true

class Pry
  class Shell
    class Client
      def initialize(process_name, host)
        @process_name = process_name
        @host = host
      end

      def to_s
        "#{process_name} @#{host}"
      end

      private

      attr_reader :process_name, :host
    end
  end
end
