# encoding: utf-8

require 'tty/table/border/ascii'
require 'tty/table/renderer/basic'

module TTY
  class Table
    class Renderer
      class ASCII < Basic
        # Create ASCII renderer
        #
        # @api private
        def initialize(table, options = {})
          super(table, options.merge(border_class: TTY::Table::Border::ASCII))
        end
      end # ASCII
    end # Renderer
  end # Table
end # TTY
