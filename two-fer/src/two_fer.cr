module TwoFer
  def self.two_fer(name : String) : String
    "One for #{name}, one for me."
  end

  def self.two_fer : String
    "One for you, one for me."
  end
end
