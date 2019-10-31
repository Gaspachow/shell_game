# encoding: utf-8

module TTY
  class Table
    # A class that represents table border options
    #
    # Used internally by {Table::Border} to manage options such as style
    #
    # @api private
    class BorderOptions < Struct.new(:characters, :separator, :style)
      # Initialize a BorderOptions
      #
      # @api public
      def initialize(*args)
        super(*args)
        self.characters = {} unless characters
      end

      # Create options instance from hash
      #
      # @api public
      def self.from(value)
        value ? new.update(value) : new
      end

      # Set all accessors with hash attributes
      #
      # @param [Hash, BorderOptions] obj
      #
      # @return [BorderOptions]
      #
      # @api public
      def update(obj)
        obj.each_pair do |key, value|
          send("#{key}=", value)
        end
        self
      end

      # Convert to hash
      #
      # @api public
      def to_hash
        hash = {}
        members.each do |key|
          value = send(key)
          hash[key.to_sym] = value if value
        end
        hash
      end
    end # BorderOptions
  end # Table
end # TTY
