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
    #rows are each line of the program
    rows = rows.split(/\n/) #split index spots to rows by splitting indexes into each new line
    @bodies = []
    loops = rows[0].to_i + 1 #number of bodies is set at the first line (index 0 as in rows)
    universe_radius = rows[1].to_f / size #radius of the univers is set as the second
    
 
    for i in 2..loops #number of bodies (loop through enough  times) syntax for a for loop is #starting nunber ... max numbers 2 dots means first is NOT included 
      column = rows[i]
      column = column.split(" ") #split each row into columns by the spaces
      
      
      @bodies.push(Body.new(column[0].to_f, column[1].to_f, column[2].to_f, column[3].to_f, column[4].to_f, column[5],column[6].to_f,column[7].to_f universe_radius))
    
      #x_pos, y_pos, vel_x, vel_y, mass, image, z_ velocity, radii_of_body, universe_radius
      # for loop will create a new body with each step, since each column is defined at row i, it then pushes each column for every time it loops through
      
      
    end#end for

  end #end initialize

  def update #calculate forces for movement
    bodies.each do |body| #go through bodies
      bodies.each do |diff_body| #stop at each index and check the body the first loop is at with every other one
        if body != diff_body

          body.calc_force(diff_body) #since forces affect every other body then it needs to be checked everytime unlike accel or velocity
                                    #since those do not have any affect on the other bodies, so only force needs to be checked.

        end
        
      end

      body.calc_acceleration()
      body.calc_velocity
      body.calc_position()
      body.calc_z_velocity()
    
      

    end

    bodies.each do |body| # go through and check all to see if planets are colliding
      bodies.each do |diff_body| 
        if body_radii_cords = diff_body_radii

          delete_body(diff_body)
          Body.new(diff_body.all_properties,diff_body.body_radii.half,calc_velocity_split())
          Body.new(diff_body.all_properties,diff_body.body_radii.half,calc_velocity_split())
          calc_velocity_split()
        end
        
    
      
      end
    end
    

  end

  def draw
  
    background_image.draw(0, 0, ZOrder::Background)

    @bodies.each do |body|
      body.draw(720) #draw function in planet class, 720 is the window size 
    end

  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
  



end

file = "simulations/planets.txt"

if ARGV.length == 0
  file = "simulations/planets.txt"
else
  sim = ARGV[0].to_s 
  puts sim
  file = "simulations/" + sim
  puts file
end

window = NbodySimulation.new(file, 720, false)

window.show
