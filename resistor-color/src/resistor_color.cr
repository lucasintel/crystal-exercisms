module ResistorColor
  enum Color
    Black
    Brown
    Red
    Orange
    Yellow
    Green
    Blue
    Violet
    Grey
    White
  end

  def self.color_code(code : String) : Int32
    Color.parse(code).to_i
  end

  def self.colors : Array(String)
    Color.names.map(&.downcase)
  end
end
