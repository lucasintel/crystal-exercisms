module CollatzConjecture
  def self.steps(number : Int32) : Int32
    if number <= 0
      raise ArgumentError.new("Number must be an integer greater than zero.")
    end

    steps = 0

    until number == 1
      case number
      when .odd?
        number = (number * 3) + 1
      else
        number = number // 2
      end

      steps += 1
    end

    steps
  end
end
