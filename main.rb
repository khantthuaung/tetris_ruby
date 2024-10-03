require 'Gosu'
require_relative 'game'

class GameWindow < Gosu::Window
  def initialize
    super 400,800, false # width, height, fullscreen
    self.caption = "Ruby Tetris" #caption
    @game = Game.new()
    @frame_count = 0
    @move_delay = 30
  end

  def update
    @frame_count += 1
    if @frame_count % @move_delay == 0
      @game.move_down()
    end
  end

  def draw()
    draw_background()
    @game.draw()
  end

  def button_down(id)
    case id
    when Gosu::KbLeft
      @game.move_left()
    when Gosu::KbRight
      @game.move_right()
    when Gosu::KbDown
      @game.move_down()
    when Gosu::KbSpace
      @game.rotate()
    end
  end


  def draw_background()
    background_color = Gosu::Color.new(255,44, 44, 127)
    draw_quad(
    0, 0, background_color, 
    400, 0, background_color, 
    800, 800, background_color, 
    0, 800, background_color)
  end
end

window = GameWindow.new
window.show