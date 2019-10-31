# encoding: utf-8

require 'forwardable'

module TTY
  # A main entry for asking prompt questions.
  class Prompt
    extend Forwardable

    # Raised when the passed in validation argument is of wrong type
    class ValidationCoercion < TypeError; end

    # Raised when the required argument is not supplied
    class ArgumentRequired < ArgumentError; end

    # Raised when the argument validation fails
    class ArgumentValidation < ArgumentError; end

    # Raised when the argument is not expected
    class InvalidArgument < ArgumentError; end

    # @api private
    attr_reader :input

    # @api private
    attr_reader :output

    attr_reader :reader

    attr_reader :cursor

    # Prompt prefix
    #
    # @example
    #   prompt = TTY::Prompt.new(prefix: [?])
    #
    # @return [String]
    #
    # @api private
    attr_reader :prefix

    # Theme colors
    #
    # @api private
    attr_reader :active_color, :help_color, :error_color

    def_delegators :@pastel, :decorate, :strip

    def_delegators :@cursor, :clear_lines, :clear_line,
                   :show, :hide

    def_delegators :@reader, :read_char, :read_line, :read_keypress,
                   :read_multiline, :on, :subscribe, :publish

    def_delegators :@output, :print, :puts, :flush

    def self.messages
      {
        range?: 'Value %{value} must be within the range %{in}',
        valid?: 'Your answer is invalid (must match %{valid})',
        required?: 'Value must be provided'
      }
    end

    # Initialize a Prompt
    #
    # @api public
    def initialize(*args)
      options = Utils.extract_options!(args)
      @input  = options.fetch(:input) { $stdin }
      @output = options.fetch(:output) { $stdout }
      @prefix = options.fetch(:prefix) { '' }
      @enabled_color = options[:enable_color]
      @active_color  = options.fetch(:active_color) { :green }
      @help_color    = options.fetch(:help_color)   { :bright_black }
      @error_color   = options.fetch(:error_color)  { :red }

      @cursor = TTY::Cursor
      @pastel = Pastel.new(@enabled_color.nil? ? {} : { enabled: @enabled_color })
      @reader = Reader.new(@input, @output, interrupt: options[:interrupt])
    end

    # Ask a question.
    #
    # @example
    #   propmt = TTY::Prompt.new
    #   prompt.ask("What is your name?")
    #
    # @param [String] message
    #   the question to be asked
    #
    # @yieldparam [TTY::Prompt::Question] question
    #   further configure the question
    #
    # @yield [question]
    #
    # @return [TTY::Prompt::Question]
    #
    # @api public
    def ask(message, *args, &block)
      options = Utils.extract_options!(args)
      options.merge!({messages: self.class.messages})
      question = Question.new(self, options)
      question.call(message, &block)
    end

    # Ask a question with a keypress answer
    #
    # @see #ask
    #
    # @api public
    def keypress(message, *args, &block)
      options = Utils.extract_options!(args)
      options.merge!(read: :keypress)
      args << options
      ask(message, *args, &block)
    end

    # Ask a question with a multiline answer
    #
    # @see @ask
    #
    # @api public
    def multiline(message, *args, &block)
      options = Utils.extract_options!(args)
      options.merge!(read: :multiline)
      args << options
      ask(message, *args, &block)
    end

    # Ask masked question
    #
    # @example
    #   propmt = TTY::Prompt.new
    #   prompt.mask("What is your secret?")
    #
    # @return [TTY::Prompt::MaskQuestion]
    #
    # @api public
    def mask(message, *args, &block)
      options = Utils.extract_options!(args)

      question = MaskQuestion.new(self, options)
      question.call(message, &block)
    end

    # Ask a question with a list of options
    #
    # @example
    #   prompt = TTY::Prompt.new
    #   prompt.select("What size?", %w(large medium small))
    #
    # @example
    #   prompt = TTY::Prompt.new
    #   prompt.select("What size?") do |menu|
    #     menu.choice :large
    #     menu.choices %w(:medium :small)
    #   end
    #
    # @param [String] question
    #   the question to ask
    #
    # @param [Array[Object]] choices
    #   the choices to select from
    #
    # @api public
    def select(question, *args, &block)
      invoke_select(List, question, *args, &block)
    end

    # Ask a question with multiple attributes activated
    #
    # @example
    #   prompt = TTY::Prompt.new
    #   choices = %w(Scorpion Jax Kitana Baraka Jade)
    #   prompt.multi_select("Choose your destiny?", choices)
    #
    # @param [String] question
    #   the question to ask
    #
    # @param [Array[Object]] choices
    #   the choices to select from
    #
    # @return [String]
    #
    # @api public
    def multi_select(question, *args, &block)
      invoke_select(MultiList, question, *args, &block)
    end

    # Ask a question with indexed list
    #
    # @example
    #   prompt = TTY::Prompt.new
    #   editors = %w(emacs nano vim)
    #   prompt.enum_select(EnumList, "Select editor: ", editors)
    #
    # @param [String] question
    #   the question to ask
    #
    # @param [Array[Object]] choices
    #   the choices to select from
    #
    # @return [String]
    #
    # @api public
    def enum_select(question, *args, &block)
      invoke_select(EnumList, question, *args, &block)
    end

    # Invoke a list type of prompt
    #
    # @example
    #   prompt = TTY::Prompt.new
    #   editors = %w(emacs nano vim)
    #   prompt.invoke_select(EnumList, "Select editor: ", editors)
    #
    # @return [String]
    #
    # @api public
    def invoke_select(object, question, *args, &block)
      options = Utils.extract_options!(args)
      choices = if block
                  []
                elsif args.empty?
                  options
                else
                  args.flatten
                end

      list = object.new(self, options)
      list.call(question, choices, &block)
    end

    # A shortcut method to ask the user positive question and return
    # true for 'yes' reply, false for 'no'.
    #
    # @example
    #   prompt = TTY::Prompt.new
    #   prompt.yes?('Are you human?')
    #   # => Are you human? (Y/n)
    #
    # @return [Boolean]
    #
    # @api public
    def yes?(message, *args, &block)
      defaults = { default: true }
      options  = Utils.extract_options!(args)
      options.merge!(defaults.reject { |k, _| options.key?(k) })

      question = ConfirmQuestion.new(self, options)
      question.call(message, &block)
    end

    # A shortcut method to ask the user negative question and return
    # true for 'no' reply.
    #
    # @example
    #   prompt = TTY::Prompt.new
    #   prompt.no?('Are you alien?') # => true
    #   # => Are you human? (y/N)
    #
    # @return [Boolean]
    #
    # @api public
    def no?(message, *args, &block)
      defaults = { default: false, type: :no }
      options  = Utils.extract_options!(args)
      options.merge!(defaults.reject { |k, _| options.key?(k) })

      question = ConfirmQuestion.new(self, options)
      !question.call(message, &block)
    end

    # Expand available options
    #
    # @example
    #   prompt = TTY::Prompt.new
    #   choices = [{
    #     key: 'Y',
    #     name: 'Overwrite',
    #     value: :yes
    #   }, {
    #     key: 'n',
    #     name: 'Skip',
    #     value: :no
    #   }]
    #   prompt.expand('Overwirte Gemfile?', choices)
    #
    # @return [Object]
    #   the user specified value
    #
    # @api public
    def expand(message, *args, &block)
      invoke_select(Expander, message, *args, &block)
    end

    # Ask a question with a range slider
    #
    # @example
    #   prompt = TTY::Prompt.new
    #   prompt.slider('What size?', min: 32, max: 54, step: 2)
    #
    # @param [String] question
    #   the question to ask
    #
    # @return [String]
    #
    # @api public
    def slider(question, *args, &block)
      options = Utils.extract_options!(args)
      slider = Slider.new(self, options)
      slider.call(question, &block)
    end

    # Print statement out. If the supplied message ends with a space or
    # tab character, a new line will not be appended.
    #
    # @example
    #   say("Simple things.", color: :red)
    #
    # @param [String] message
    #
    # @return [String]
    #
    # @api public
    def say(message = '', options = {})
      message = message.to_s
      return unless message.length > 0

      statement = Statement.new(self, options)
      statement.call(message)
    end

    # Print statement(s) out in red green.
    #
    # @example
    #   prompt.ok "Are you sure?"
    #   prompt.ok "All is fine!", "This is fine too."
    #
    # @param [Array] messages
    #
    # @return [Array] messages
    #
    # @api public
    def ok(*args)
      options = Utils.extract_options!(args)
      args.each { |message| say message, options.merge(color: :green) }
    end

    # Print statement(s) out in yellow color.
    #
    # @example
    #   prompt.warn "This action can have dire consequences"
    #   prompt.warn "Carefull young apprentice", "This is potentially dangerous"
    #
    # @param [Array] messages
    #
    # @return [Array] messages
    #
    # @api public
    def warn(*args)
      options = Utils.extract_options!(args)
      args.each { |message| say message, options.merge(color: :yellow) }
    end

    # Print statement(s) out in red color.
    #
    # @example
    #   prompt.error "Shutting down all systems!"
    #   prompt.error "Nothing is fine!", "All is broken!"
    #
    # @param [Array] messages
    #
    # @return [Array] messages
    #
    # @api public
    def error(*args)
      options = Utils.extract_options!(args)
      args.each { |message| say message, options.merge(color: :red) }
    end

    # Takes the string provided by the user and compare it with other possible
    # matches to suggest an unambigous string
    #
    # @example
    #   prompt.suggest('sta', ['status', 'stage', 'commit', 'branch'])
    #   # => "status, stage"
    #
    # @param [String] message
    #
    # @param [Array] possibilities
    #
    # @param [Hash] options
    # @option options [String] :indent
    #   The number of spaces for indentation
    # @option options [String] :single_text
    #   The text for a single suggestion
    # @option options [String] :plural_text
    #   The text for multiple suggestions
    #
    # @return [String]
    #
    # @api public
    def suggest(message, possibilities, options = {})
      suggestion = Suggestion.new(options)
      say(suggestion.suggest(message, possibilities))
    end

    # Gathers more than one aswer
    #
    # @example
    #   prompt.collect do
    #     key(:name).ask('Name?')
    #   end
    #
    # @return [Hash]
    #   the collection of answers
    #
    # @api public
    def collect(options = {}, &block)
      collector = AnswersCollector.new(self, options)
      collector.call(&block)
    end

    # Check if outputing to terminal
    #
    # @return [Boolean]
    #
    # @api public
    def tty?
      stdout.tty?
    end

    # Return standard in
    #
    # @api private
    def stdin
      $stdin
    end

    # Return standard out
    #
    # @api private
    def stdout
      $stdout
    end

    # Return standard error
    #
    # @api private
    def stderr
      $stderr
    end
  end # Prompt
end # TTY
