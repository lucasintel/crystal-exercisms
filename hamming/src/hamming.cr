module Hamming
  def self.distance(left : String, right : String) : Int32
    raise ArgumentError.new if left.size != right.size

    left.chars.zip(right.chars).reduce(0) do |sum, pair|
      next sum if pair[0] == pair[1]

      sum += 1
    end
  end
end
