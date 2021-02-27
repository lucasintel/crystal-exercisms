module Raindrops
  def self.convert(num : Int32) : String
    String.build do |str|
      str << "Pling" if num % 3 == 0
      str << "Plang" if num % 5 == 0
      str << "Plong" if num % 7 == 0
      str << num.to_s if str.empty?
    end
  end
end
