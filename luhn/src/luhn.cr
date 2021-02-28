module Luhn
  def self.valid?(card_number : String) : Bool
    numbers = card_number.delete(' ')
    return false if numbers.size <= 1 || numbers =~ /\D/

    result = 0

    numbers.reverse.each_char_with_index do |char, index|
      if index.odd?
        doubled = char.to_i * 2
        doubled = doubled - 9 if doubled > 9

        result += doubled
      else
        result += char.to_i
      end
    end

    result.divisible_by?(10)
  end
end
