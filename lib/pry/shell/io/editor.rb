# frozen_string_literal: true

class Pry
  class Shell
    module IO
      class Editor
        DUMMY_RETURN = "true"

        def self.open(file, line)
          new(file, line).open && DUMMY_RETURN
        end

        def initialize(file, line)
          @file = file
          @line = line
        end

        def open
          File.write(file, proxy_editor)
        end

        private

        attr_reader :file, :line

        def proxy_editor
          Pry::Editor.new(Pry.new).edit_tempfile_with_content(content, line)
        end

        def content
          File.read(file)
        end
      end
    end
  end
end
