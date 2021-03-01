module ReverseString
  # Still ~10 times slower than the stdlib implementation!
  def self.reverse(string : String) : String
    return string if string.bytesize <= 1

    iterator = Char::Reader.new(at_end: string)

    String.build(string.bytesize) do |str|
      str << iterator.current_char

      while iterator.has_previous?
        str << iterator.previous_char
      end
    end
  end
end
