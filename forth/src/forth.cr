module Forth
  # https://www.forth.com/starting-forth/2-stack-manipulation-operators-arithmetic
  module Operation
    class OperationError < Exception
    end

    module Add
      def self.call(stack)
        if stack.size == 1
          raise OperationError.new("Cannot add when there is only one value on the stack.")
        end

        left, right = stack.pop(2)
        result = left + right

        stack.push(result)
      end
    end

    module Subtract
      def self.call(stack)
        if stack.size == 1
          raise OperationError.new("Cannot subtract when there is only one value on the stack.")
        end

        left, right = stack.pop(2)
        result = left - right

        stack.push(result)
      end
    end

    module Multiply
      def self.call(stack)
        if stack.size == 1
          raise OperationError.new("Cannot multiply when there is only one value on the stack.")
        end

        left, right = stack.pop(2)
        result = left * right

        stack.push(result)
      end
    end

    module Divide
      def self.call(stack)
        if stack.size == 1
          raise OperationError.new("Cannot divide when there is only one value on the stack.")
        end

        left, right = stack.pop(2)
        result = left // right

        stack.push(result)
      end
    end

    module Dup
      def self.call(stack)
        stack.push(stack[-1])
      end
    end

    module Drop
      def self.call(stack)
        stack.pop
      end
    end

    module Swap
      def self.call(stack)
        if stack.size == 1
          raise OperationError.new("Cannot SWAP when there is only one value on the stack.")
        end

        left, right = stack.pop(2)

        stack.push(right)
        stack.push(left)
      end
    end

    module Over
      def self.call(stack)
        if stack.size == 1
          raise OperationError.new("Cannot OVER when there is only one value on the stack.")
        end

        stack.push(stack[-2])
      end
    end
  end

  OPERATORS = {
    "+"    => Operation::Add,
    "-"    => Operation::Subtract,
    "*"    => Operation::Multiply,
    "/"    => Operation::Divide,
    "dup"  => Operation::Dup,
    "drop" => Operation::Drop,
    "swap" => Operation::Swap,
    "over" => Operation::Over,
  }

  WHITESPACE = ' '
  COLON      = ':'
  SEMICOLON  = ';'

  class WordExpander
    def self.expand_words(string : String) : String
      new(string).expand_words
    end

    def initialize(string : String)
      @iterator = Char::Reader.new(string)
      @words = {} of String => String
    end

    def expand_words : String
      register_words

      command = @iterator.string.split(SEMICOLON).last

      @words.reduce(command) do |acc, (word, value)|
        acc = command.gsub(word, value)
      end
    end

    private def register_words
      while @iterator.any?
        char = @iterator.current_char

        case char
        when COLON
          register_word
        else
          @iterator.next_char
          next
        end
      end
    end

    private def register_word
      if @iterator.next_char != WHITESPACE
        raise ParseError.new("Expected whitespace after colon.")
      end

      @iterator.next_char

      word_name_chars = [] of Char
      while @iterator.any? && @iterator.current_char != WHITESPACE
        char = @iterator.current_char

        if char.ascii_number?
          raise ParseError.new("Invalid word name: #{char}.")
        end

        word_name_chars << char

        @iterator.next_char
      end

      word_name = word_name_chars.join
      raise ParseError.new("Could not register empty word.") if word_name.blank?

      value_chars = [] of Char
      while @iterator.any? && @iterator.current_char != SEMICOLON
        value_chars << @iterator.current_char
        @iterator.next_char
      end

      value = value_chars.join
      raise ParseError.new("Cannot assign empty value to word.") if value.blank?

      @words[word_name] = value
    end
  end

  class Executor
    def self.evaluate(string : String)
      new(string).evaluate
    end

    def initialize(string : String)
      @iterator = Char::Reader.new(string)
      @stack = [] of Int32
    end

    def evaluate
      while @iterator.any?
        char = @iterator.current_char

        case char
        when WHITESPACE
          @iterator.next_char
          next
        when .ascii_number?
          read_number
        else
          execute
        end
      end

      @stack
    end

    def read_number
      number_chars = [] of Char

      while @iterator.current_char.ascii_number?
        number_chars << @iterator.current_char
        @iterator.next_char
      end

      @stack << number_chars.join.to_i
    end

    def execute
      raise ParseError.new("Cannot execute an empty stack.") if @stack.empty?

      operator_name_chars = [] of Char

      while @iterator.any? && @iterator.current_char != WHITESPACE
        operator_name_chars << @iterator.current_char
        @iterator.next_char
      end

      operator_name = operator_name_chars.join
      operator = OPERATORS[operator_name]?

      unless operator
        raise ParseError.new("Invalid operator name: #{operator_name}.")
      end

      operator.call(@stack)
    end
  end

  class ParseError < Exception
  end

  def self.evaluate(raw_string : String)
    string = raw_string.downcase
    expanded_string = WordExpander.expand_words(string)

    Executor.evaluate(expanded_string)
  end
end
