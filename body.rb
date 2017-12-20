require "gosu"
require 'mathn'
require './z_order'
require_relative "z_order"

class Body

	attr_accessor :x, :y, :vel_x, :vel_y, :mass, :image, :force, :g, :ax, :ay, :t #, vel_z

	def initialize(x, y, vel_x, vel_y, mass, image, vel_z)
        @x = x.to_f
        @y = y.to_f
        @vel_x = vel_x.to_f
        @vel_y = vel_y.to_f
        @mass = mass.to_f
        @image = image
        @force = [0.0, 0.0]
        #@vel_z = vel_z.to_f 
	end

    def set_force(f)
        self.force[0] = f[0]
        self.force[1] = f[1]
        #self.force[2] = f[2]
    end

    def how_far(body1, body2)
    	dx = (body2.x - body1.x)
    	dy = (body2.y - body1.y)
        return [dx, dy]
    end

    def length(body1, body2)
    	distance = how_far(body1, body2)
        return Math.sqrt((distance[0] * distance[0]) + (distance[1] * distance[1]))
    end

    def forcex(mass1, mass2, r)
    	g = 6.67408e-11
    	return (g * mass1 * mass2) / (r ** 2)
    end

    def force_directional(f, distance, radius)
    	return (distance / radius) * f
    end

    def acceleration(f, mass)
    	return (f / mass)
    end

    def distance(v, v0)
    	return v0 + (v * 25000)
    end

    def velocity(a, v0)
    	return v0 + (a * 25000)
    end

#   def z_velocity()
# 	Over here, I need to make the bodies grow and shrink
# 	based on their distance from the origin

    def calculate_force(bodies)
        f, fx, fy, dx, dy, r = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
        
        bodies.each do |body|
            if body == self
            	next
            end
            radius = length(self, body)
            dx = how_far(self, body)[0]
            dy = how_far(self, body)[1]
#           dz = how_far(self, body)[2]

            f = forcex(mass, body.mass, radius)

            fx += force_directional(f, dx, radius)
            fy -= force_directional(f, dy, radius)
#           fz += force_directional(f, dz, radius)

            f = 0.0
        end

        return [fx, fy]
    end

    def set_coordinates(bodies)
        set_force(calculate_force(bodies))

        v0x = vel_x
        v0y = vel_y

        ax = acceleration(force[0], mass)
        ay = acceleration(force[1], mass)

        self.vel_x = velocity(ax, v0x)
        self.vel_y = velocity(ay, v0y)
#       self.vel_z = velocity(az, v0z)

        self.x += distance(vel_x, v0x)
        self.y -= distance(vel_y, v0y)
# 		self.z += distance(vel_z, v0z)
    end

    def convert(radius)
        x_coordinate = ((320 * @x) / radius) + 320
        y_coordinate = ((320 * @y) / radius) + 320
#       z_coordinate = ((320 * @y) / radius) + 320
        return x_coordinate, y_coordinate #, z_coordinate
    end

    def draw(radius)
        image = Gosu::Image.new("images/#{@image}")
        x_coordinate, y_coordinate = convert(radius)
        image.draw(x_coordinate, y_coordinate, ZOrder::Body)
    end

 #    def collide(body1, body2, radius)
	# 	if (body2.x + body1.x) > self.x
	# 		body2.x = body2.x / 2 && body1.x = body1.x / 2
	# 	end
	# end


	

end