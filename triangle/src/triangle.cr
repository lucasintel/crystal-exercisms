struct Triangle
  alias Length = Int32 | Int64 | Float32 | Float64

  def self.triangle?(sides : Tuple(Length, Length, Length)) : Bool
    return false if sides.sum <= 0

    sides[0] + sides[1] >= sides[2] &&
      sides[1] + sides[2] >= sides[0] &&
      sides[0] + sides[2] >= sides[1]
  end

  def initialize(@sides : Tuple(Length, Length, Length))
    if !self.class.triangle?(@sides)
      raise ArgumentError.new("Uh? Not a triangle!")
    end
  end

  def equilateral? : Bool
    @sides.to_set.size == 1
  end

  def isosceles? : Bool
    @sides.to_set.size <= 2
  end

  def scalene? : Bool
    @sides.to_set.size == 3
  end
end
