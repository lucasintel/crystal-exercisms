#
# Run-length encoding (RLE) is a simple form of data compression,
# where runs (consecutive data elements) are replaced by just
# one data value and count.
#
# For example we can represent the original 53 characters
# with only 13.
#
# ```
# "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
# "12WB12W3B24WB"
# ```
#
# RLE allows the original data to be perfectly reconstructed
# from the compressed data, which makes it a lossless data
# compression.
#
# ```
# "AABCCCDEEEE" <=> "2AB3CD4E" <=> "AABCCCDEEEE"
# ```
module RunLengthEncoding
  def self.encode(string : String) : String
    String.build do |str|
      acc = 1
      reader = Char::Reader.new(string)
      reader.each do |char|
        if reader.peek_next_char == char
          acc += 1
        else
          str << acc if acc > 1
          str << char
          acc = 1
        end
      end
    end
  end

  def self.decode(string : String) : String
    String.build do |str|
      acc = 0
      string.each_char do |char|
        if char.number?
          acc = (acc * 10) + char.to_i
        else
          if acc > 0
            acc.times { str << char }
          else
            str << char
          end
          acc = 0
        end
      end
    end
  end
end
