require 'Gosu'
require_relative 'lib/grid' #calling the grid class from the lib folder

class GameWindow < Gosu::Window
  def initialize
    super 400,800, false # width, height, fullscreen
    self.caption = "Ruby Tetris" #caption
  end

  def update
    
  end

  def draw
    draw_background()
    grid = Grid.new()
    grid.print_grid
    grid.draw()
    
  end

  def draw_background()
    background_color = Gosu::Color.new(255,44, 44, 127)
    draw_quad(
    0, 0, background_color, 
    400, 0, background_color, 
    400, 800, background_color, 
    0, 800, background_color)
  end
end

window = GameWindow.new
window.show