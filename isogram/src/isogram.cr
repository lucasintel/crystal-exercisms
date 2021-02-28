require "benchmark"

module Isogram
  def self.isogram?(word : String) : Bool
    relevant_chars = word.chars.reduce([] of Char) do |acc, char|
      next acc unless char.letter?

      acc << char.downcase
    end

    relevant_chars.uniq.size == relevant_chars.size
  end
end
