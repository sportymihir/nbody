module Calc


	def how_far(b1, b2)
		dx = (b2.x - b1.x)
        dy = (b2.y - b1.y)
        return [dx, dy]
    end

    def length()
    	d = calc.how_far(b1, b2)
    	return Math.sqrt(d[0] ** 2 + d[1] ** 2)
    end

    def force(m1, m2, r)
    	g = 6.67408 * (10 ** -11)
        return (g * m1 * m2) / (r ** 2)
    end

    def force_direction(f, d, r)
    	return f * (d / r)

	end

	def acceleartion(f, m)
		return f / m
	end

	def velocity(a, v0)
        return (a * 250000) + v0
    end

    def distance(v0, v)
        return v0 + (v * 250000)
    end

end

