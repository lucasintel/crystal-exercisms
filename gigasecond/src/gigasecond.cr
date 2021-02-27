module Gigasecond
  private GIGASECOND_SPAN = 1e9.seconds

  def self.from(time : Time) : Time
    time + GIGASECOND_SPAN
  end
end
