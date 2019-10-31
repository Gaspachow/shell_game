# encoding: utf-8

require 'tty/table/renderer/basic'
require 'tty/table/renderer/ascii'
require 'tty/table/renderer/unicode'

module TTY
  class Table
    # A class responsible for rendering tabular data
    #
    # Used internally by {Table} to render table content out.
    #
    # @api private
    class Renderer
      RENDERER_MAPPER = {
        ascii:   TTY::Table::Renderer::ASCII,
        basic:   TTY::Table::Renderer::Basic,
        unicode: TTY::Table::Renderer::Unicode
      }

      # Select renderer class based on string name.
      #
      # The possible values for renderer are
      #   [:basic, :ascii, :unicode]
      #
      # @param [Symbol] renderer
      #   the renderer used for displaying table
      #
      # @return [TTY::Table::Renderer]
      #
      # @api private
      def self.select(type)
        RENDERER_MAPPER[type || :basic]
      end

      # Raises an error if provided border class is of wrong type or has invalid
      # implementation
      #
      # @raise [TypeError]
      #   raised when providing wrong class for border
      #
      # @raise [NoImplementationError]
      #   raised when border class does not implement core methods
      #
      # @api public
      def self.assert_border_class(border_class)
        return unless border_class
        unless border_class <= TTY::Table::Border
          fail TypeError,
               "#{border_class} should inherit from TTY::Table::Border"
        end
        unless border_class.characters
          fail NoImplementationError,
               "#{border_class} should implement def_border"
        end
      end

      # Add custom border for the renderer
      #
      # @param [TTY::Table::Border] border_class
      #
      # @param [TTY::Table] table
      #
      # @param [Hash] options
      #
      # @raise [TypeError]
      #   raised if the klass does not inherit from Table::Border
      #
      # @raise [NoImplemntationError]
      #   raise if the klass does not implement def_border
      #
      # @api public
      def self.render_with(border_class, table, options = {}, &block)
        assert_border_class(border_class)
        options[:border_class] = border_class if border_class
        render(table, options, &block)
      end

      # Render a given table and return the string representation.
      #
      # @param [TTY::Table] table
      #   the table to be rendered
      #
      # @param [Hash] options
      #   the options to render the table with
      # @option options [String] :renderer
      #   used to format table output
      #
      # @return [String]
      #
      # @api public
      def self.render(table, options = {}, &block)
        renderer = select(options[:renderer]).new(table, options)
        yield renderer if block_given?
        renderer.render
      end
    end # Renderer
  end # Table
end # TTY
