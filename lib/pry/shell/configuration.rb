# frozen_string_literal: true

class Pry
  class Shell
    class Configuration
      CONFIG_KEYS = {
        host: "localhost",
        port: "1881",
        auto_connect: false
      }.freeze

      CONFIG_KEYS.each do |config_key, default_value|
        attr_writer config_key

        define_method(config_key) do
          return default_value unless instance_variable_defined?("@#{config_key}")

          instance_variable_get("@#{config_key}")
        end
      end
    end
  end
end
