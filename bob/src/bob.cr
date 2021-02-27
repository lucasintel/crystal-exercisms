module Bob
  def self.hey(sentence : String) : String
    return "Fine. Be that way!" if sentence.blank?

    letters = sentence.chars.select(&.ascii_letter?)
    shoutting = letters.any? && letters.all?(&.uppercase?)

    if shoutting && sentence.ends_with?('?')
      "Calm down, I know what I'm doing!"
    elsif shoutting
      "Whoa, chill out!"
    elsif sentence.ends_with?('?')
      "Sure."
    else
      "Whatever."
    end
  end
end
