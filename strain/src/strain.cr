class Array(T)
  def keep(&block) : Array(T)
    filtered_array = [] of T

    each do |el|
      keep = yield(el)
      filtered_array << el if keep
    end

    filtered_array
  end

  def discard(&block) : Array(T)
    filtered_array = [] of T

    each do |el|
      discard = yield(el)
      filtered_array << el unless discard
    end

    filtered_array
  end
end
