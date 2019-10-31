# encoding: utf-8

require 'verse'

module TTY
  class Table
    module Operation
      # A class responsible for shortening text.
      #
      # @api private
      class Truncation

        attr_reader :widths

        # Initialize a Truncation
        #
        # @api public
        def initialize(widths)
          @widths = widths
        end

        # Apply truncation to a field
        #
        # @param [TTY::Table::Field] field
        #   the table field
        #
        # @param [Integer] row
        #   the field row index
        #
        # @param [Integer] col
        #   the field column index
        #
        # @return [TTY::Table::Field]
        #
        # @api public
        def call(field, row, col)
          width = widths[col] || field.width
          Verse.truncate(field.content, width)
        end
      end # Truncation
    end # Operation
  end # Table
end # TTY
