# encoding: utf-8

module TTY
  class Table
    # A class responsible for indenting table representation
    class Indentation
      # The amount of indentation
      #
      # @api public
      attr_accessor :indentation

      # Initialize an Indentation
      #
      # @api public
      def initialize(indentation)
        @indentation = indentation
      end

      # Return a table part with indentation inserted
      #
      # @param [#map, #to_s] part
      #   the rendered table part
      #
      # @api public
      def indent(part)
        if part.respond_to?(:to_a)
          part.map { |line| insert_indentation(line) }
        else
          insert_indentation(part)
        end
      end

      private

      # Insert indentation into a table renderd line
      #
      # @param [#to_a, #to_s] line
      #   the rendered table line
      #
      # @api public
      def insert_indentation(line)
        line = line.is_a?(Array) ? line[0] : line
        line.insert(0, ' ' * indentation) if line
      end
    end # Indentation
  end # Table
end # TTY
