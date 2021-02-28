module Pangram
  ALPHABET = ('a'..'z').to_a

  def self.pangram?(sentence : String)
    (sentence.chars.map(&.downcase) & ALPHABET).size == ALPHABET.size
  end
end
