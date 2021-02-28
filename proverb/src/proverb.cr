module Proverb
  TEMPLATE = "For want of a %s the %s was lost."
  CLIMAX   = "And all for the want of a %s."

  def self.recite(array : Array(String)) : Array(String)
    result = [] of String
    return result if array.empty?

    array.each_cons(2) do |pair|
      result << TEMPLATE % pair
    end

    result << CLIMAX % array.first

    result
  end
end
