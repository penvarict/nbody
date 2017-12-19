require "gosu"
require "./Body"
require_relative "z_order"

class NbodySimulation < Gosu::Window
  
  attr_accessor :bodies, :background_image, :universe_radius, :size

  def initialize(file, size, screen)

    super(size, size, screen) #create window
    
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    simulation = open(file)

    rows = simulation.read
    
    rows = rows.split(/\n/) #split index spots to rows
    @bodies = []
    loops = rows[0].to_i + 1
    universe_radius = rows[1].to_f / size
    
 
    for i in 2..loops #number of bodies (loop through enough  times)
      column = rows[i]
      column = column.split
      
      
      @bodies.push(Body.new(column[0].to_f, column[1].to_f, column[2].to_f, column[3].to_f, column[4].to_f, column[5], universe_radius))
    
      #print "#{column[0]}\n"
      
      #print "#{column[4]}\n"
      #x_pos, y_pos, vel_x, vel_y, mass, image, universe_radius
      
      
    end#end for

  end #end initialize

  def update #calculate forces for movement, functions for calculations are in planet
    bodies.each do |body|
      bodies.each do |diff_body|
        if body != diff_body

          body.calc_force(diff_body)

        end
        
      end

      body.calc_acceleration()
      body.calc_velocity
      body.calc_position()

    end

  end

  def draw
  
    background_image.draw(0, 0, ZOrder::Background)

    @bodies.each do |body|
      body.draw(720) #draw function in planet class
    end

  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
  



end

file = "simulations/planets.txt"

window = NbodySimulation.new(file, 720, false)

window.show
