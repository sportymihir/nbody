require "gosu"
require_relative "universe"

class NbodySimulation < Gosu::Window

  attr_accessor :universe

  def initialize(simulation, size)
    size = size.to_i >= 200 ? size.to_i : 800
    simulation = simulation || "planets"

    super(size, size, false)
    self.caption = "#{simulation} simulation"
    
    simulation_file = "simulations/#{simulation}.txt"
    
    @universe = Universe.new(simulation_file, self)
  end

  def update
    universe.update
  end

  def draw
    universe.draw
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
  
end

window = NbodySimulation.new(ARGV[0], ARGV[1].to_i)
window.show