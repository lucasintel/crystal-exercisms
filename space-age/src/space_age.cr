require "big"

module Space
  class Age
    EARTH_YEAR_IN_SECONDS = 31_557_600

    MERCURY_RELATIVE_ORBITAL_PERIOD =  0.2408467
    VENUS_RELATIVE_ORBITAL_PERIOD   = 0.61519726
    MARS_RELATIVE_ORBITAL_PERIOD    =  1.8808158
    JUPITER_RELATIVE_ORBITAL_PERIOD =  11.862615
    SATURN_RELATIVE_ORBITAL_PERIOD  =  29.447498
    URANUS_RELATIVE_ORBITAL_PERIOD  =  84.016846
    NEPTUNE_RELATIVE_ORBITAL_PERIOD =  164.79132

    def self.from_seconds(seconds : Float64)
      age = seconds / EARTH_YEAR_IN_SECONDS
      new(age)
    end

    def initialize(@age : Float64)
    end

    def age_on_earth
      @age
    end

    {% begin %}
      {% for planet in %w[mercury venus mars jupiter saturn uranus neptune] %}
        def age_on_{{planet.id}}
          @age / {{planet.upcase.id}}_RELATIVE_ORBITAL_PERIOD
        end
      {% end %}
    {% end %}
  end
end
