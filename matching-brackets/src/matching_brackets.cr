module MatchingBrackets
  PAIRS = {
    '[' => ']',
    '{' => '}',
    '(' => ')',
  }

  def self.valid?(string : String) : Bool
    stack = [] of Char

    string.each_char do |char|
      case PAIRS
      when .has_key?(char)
        stack.push(char)
      when .has_value?(char)
        return false if stack.empty?
        return false if PAIRS[stack.pop] != char
      end
    end

    stack.size == 0
  end
end
