# encoding: utf-8

require 'tty/table/column_set'
require 'tty/table/border/null'

module TTY
  class Table
    # A class responsible for enforcing column constraints.
    #
    # Used internally by {Renderer::Basic} to enforce correct column widths.
    #
    # @api private
    class ColumnConstraint
      MIN_WIDTH = 1

      BORDER_WIDTH = 1

      attr_reader :table

      attr_reader :renderer

      # Initialize a Columns
      #
      # @param [TTY::Table] table
      #
      # @param [TTY::Table::Renderer] renderer
      #
      # @api public
      def initialize(table, renderer)
        @table    = table
        @renderer = renderer
      end

      # Estimate outside border size
      #
      # @return [Integer]
      #
      # @api public
      def outside_border_size
        renderer.border_class == TTY::Table::Border::Null ? 0 : 2
      end

      # Total border size
      #
      # @return [Integer]
      #
      # @api public
      def border_size
        BORDER_WIDTH * (table.columns_size - 1) + outside_border_size
      end

      # Measure total padding size for a table
      #
      # @return [Integer]
      #
      # @api public
      def padding_size
        padding = renderer.padding
        (padding.left + padding.right) * (table.columns_size - 1)
      end

      # Estimate minimum table width to be able to display content
      #
      # @return [Integer]
      #
      # @api public
      def minimum_width
        table.columns_size * MIN_WIDTH + border_size
      end

      # Return column's natural unconstrained widths
      #
      # @return [Integer]
      #
      # @api public
      def natural_width
        renderer.column_widths.inject(0, &:+) + border_size + padding_size
      end

      # Return the constrained column widths.
      #
      # Account for table field widths and any user defined
      # constraints on the table width.
      #
      # @api public
      def enforce
        assert_minimum_width

        if natural_width <= renderer.width
          renderer.resize ? expand : renderer.column_widths
        else
          if renderer.resize
            shrink
          else
            rotate
          end
        end
      end

      private

      # Rotate table to vertical orientation and print information to stdout
      #
      # @api private
      def rotate
        Kernel.warn 'The table size exceeds the currently set width.' \
                   'To avoid error either. Defaulting to vertical ' \
                   'orientation.'
        table.orientation = :vertical
        table.rotate
        ColumnSet.widths_from(table)
      end

      # Expand column widths to match the requested width
      #
      # @api private
      def expand
        column_size = table.columns_size
        ratio       = ((renderer.width - natural_width) / column_size.to_f).floor

        widths = (0...column_size).reduce([]) do |lengths, col|
          lengths + [renderer.column_widths[col] + ratio]
        end
        distribute_extra_width(widths)
      end

      # Shrink column widths to match the requested width
      #
      # @api private
      def shrink
        column_size = table.columns_size
        ratio       = ((natural_width - renderer.width) / column_size.to_f).ceil

        widths = (0...column_size).reduce([]) do |lengths, col|
          lengths + [renderer.column_widths[col] - ratio]
        end
        distribute_extra_width(widths)
      end

      # Assert minimum width for the table content
      #
      # @raise [TTY::ResizeError]
      #
      # @api private
      def assert_minimum_width
        width = renderer.width
        return unless width <= minimum_width
        fail ResizeError, "Table's width is too small to contain the content " \
                          "(min width #{minimum_width}, currently set #{width})"
      end

      # Distribute remaining width to meet the total width requirement.
      #
      # @param [Array[Integer]] widths
      #
      # @api private
      def distribute_extra_width(widths)
        column_size     = table.columns_size
        # TODO - add padding size to fully check extra width
        extra_width     = renderer.width - (widths.reduce(:+) + border_size)
        per_field_width = extra_width / column_size
        remaining_width = extra_width % column_size
        extra = [1] * remaining_width + [0] * (column_size - remaining_width)

        widths.map.with_index do |width, index|
          width + per_field_width + extra[index]
        end
      end
    end # ColumnConstraint
  end # Table
end # TTY
