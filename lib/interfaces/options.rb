require 'Gosu'
require_relative '../color'

class Options
  def initialize()
    @font = Gosu::Font.new(40, name:"lib/fonts/ThaleahFat.ttf")
    
  end

  def draw()
    Gosu.draw_rect(0, 0, 800, 680, Gosu::Color::WHITE)
    @font.draw("Options", 250, 40, 1, 1.0, 1.0, Gosu::Color::BLACK)
  end
end
