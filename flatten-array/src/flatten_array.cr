module FlattenArray
  def self.flatten(array : Array, result = [] of Int32) : Array(Int32)
    array.each do |element|
      case element
      when Array
        flatten(element, result)
      when Nil
      else
        result << element
      end
    end

    result
  end
end
