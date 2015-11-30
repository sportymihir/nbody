require "gosu"
require_relative "z_order"

class Body

	DT = 20000
	G = 6.67408*10**-11

	attr_reader :mass, :x, :y, :name

	def initialize(planet_string)
		data = planet_string.strip.split(' ')
		@x = data[0].to_f
		@y = data[1].to_f
		@v_x = data[2].to_f
		@v_y = -1 * data[3].to_f
		@a_x = 0
		@a_y = 0
		@f_x = 0
		@f_y = 0
		@mass = data[4].to_f
		img_file = data[5]
		@name = img_file[0..-5]
		@image = Gosu::Image.new("images/#{img_file}")
	end

	def update
		calculate_acceleration
		calculate_velocity
		calculate_position
	end

	def reset_forces
		@f_x = 0
		@f_y = 0
	end

	def add_force_from(other_body)
		dx = other_body.x - x
		dy = other_body.y - y
		r = Math.sqrt(dx*dx + dy*dy)
		total_force = G * mass * other_body.mass / (r*r)
		@f_x += total_force * dx / r
		@f_y += total_force * dy / r
	end

	def draw(window)
		x, y = window.coordinates_for(@x, @y)
		@image.draw_rot(x, y, ZOrder::Body, 0)
	end

	private

		def calculate_acceleration
			@a_x = @f_x / @mass
			@a_y = @f_y / @mass
		end

		def calculate_velocity
			@v_x += @a_x * DT
			@v_y += @a_y * DT
		end

		def calculate_position
			@x += @v_x * DT
			@y += @v_y * DT
		end
	
end