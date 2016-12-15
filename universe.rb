require "gosu"
require_relative "body"
require_relative "z_order"

class Universe

	def initialize(simulation_file, window)
		@window = window
		@background_image = Gosu::Image.new("images/space.jpg", tileable: true)

		load_simulation(simulation_file)
	end

	def update
    reset
    find_forces
    update_bodies
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    
    @bodies.each { |body| body.draw(self) }
  end

  def coordinates_for(x, y)
	  [scale(x, @window.width), scale(y, @window.height)]
	end

  private

		def load_simulation(filename)
	    lines = File.read(filename).strip.split("\n")
	    @radius = lines[1].to_f
	    planet_strings = lines[2...(2+lines[0].to_i)].select {|line| line != ''}
	    @bodies = planet_strings.map { |planet_string| Body.new(planet_string) }
	  end

	  def scale(dimension, measurement)
      dimension / diameter * measurement.to_f + measurement / 2.0
    end

    def diameter
      2 * @radius
    end

    def reset
      @bodies.each do |body|
        body.reset_forces
      end
    end

    def find_forces
      @bodies.each do |body|
        @bodies.each do |other|
          body.add_force_from(other) unless body == other
        end
      end
    end

    def update_bodies
      @bodies.each { |body| body.update }
    end

end