# frozen_string_literal: true

class Pry
  class Shell
    class Client
      def initialize(id, process_name, host)
        @id = id
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
