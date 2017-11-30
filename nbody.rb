require "gosu"
require_relative "z_order"
STDOUT.sync = true

file_name = ARGV
x_cords = []
y_cords = []
x_acel = []
y_acel = []


File.open("#{file_name}").each do |line|
  info = line.split(" ")
  if line == 0


  end

  if line == 1



  end
  x = info[0]



end

class NbodySimulation < Gosu::Window

  def initialize
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
  end

  def update
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
  
end

window = NbodySimulation.new
window.show