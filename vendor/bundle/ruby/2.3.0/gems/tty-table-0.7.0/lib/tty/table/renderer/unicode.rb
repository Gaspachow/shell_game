# encoding: utf-8

require 'tty/table/border/unicode'

module TTY
  class Table
    class Renderer
      # Unicode representation of table renderer
      #
      # @api private
      class Unicode < Basic
        # Create Unicode renderer
        #
        # @param [Table] table
        #
        # @api private
        def initialize(table, options = {})
          super(table, options.merge(border_class: TTY::Table::Border::Unicode))
        end
      end # Unicode
    end # Renderer
  end # Table
end # TTY
