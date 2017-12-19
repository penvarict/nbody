require "gosu"
require_relative "z_order"


G = 6.674e-11


class Body 

    attr_accessor :file, :x_cords, :y_cords, :mass
    

    def initialize(x_cords, y_cords, x_vel, y_vel, mass, file, radius_of_universe)
    @x_cords = x_cords.to_f
    @y_cords = y_cords.to_f
    @x_vel = x_vel.to_f
    @y_vel = y_vel.to_f
    @mass = mass.to_f
    @file = file
    @image_file = "images/#{@file}"
    @image = Gosu::Image.new(@image_file)
    @diameter = radius_of_universe * 2
    
    @x_accel = @y_accel = @x_force = @y_force = @x_cords_relative = @y_cords_relative

    end


    def draw(size)

        @y_cords_relative = -1*(@y_cords/@diameter)+ 720
        @x_cords_relative = (@x_cords/@diameter) + 720
        center_x = @x_cords_relative.to_f - @image.width/2.0 - (size/2)
        center_y = @y_cords_relative.to_f - @image.width/2.0 - (size/2)
    


        @image.draw((center_x), (center_y), ZOrder::Foreground)
        

    end


    def calc_force(other_body)
        # print "#{other_body.x_cords}\n"
        # print other_body.mass
        d_x = @x_cords - other_body.x_cords
        d_y= @y_cords - other_body.y_cords
        d = Math.sqrt (d_x**2 + d_y**2)
        
        force_excerted = ((G* @mass * other_body.mass)/d**2).to_f


        @x_force = @x_force.to_f - ((force_excerted * (@x_cords - other_body.x_cords))/d).to_f

        @y_force = @y_force.to_f - ((force_excerted * (@y_cords - other_body.y_cords))/d).to_f

    end
    
    def calc_acceleration()
        #f=ma a=f/m


         @x_accel= @x_force.to_f / @mass.to_f
         @y_accel= @y_force.to_f / @mass.to_f
        

        @x_force = @y_force = 0
        print "my mass is #{@mass}\n"
        print "my x_force is #{@x_force}\n"

        print "my x accel is #{@x_accel}\n"
        print "my y accel is #{@y_accel}\n"
    end
    
    def calc_velocity()
        
        @x_vel = @x_vel.to_f + 25000 * @x_accel.to_f 
        @y_vel = @y_vel.to_f + 25000 * @y_accel.to_f 


    end

    def calc_position()
        @x_cords = @x_cords.to_f + (@x_vel * 25000)
        @y_cords = @y_cords.to_f + (@y_vel * 25000)
    end





end