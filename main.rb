require 'Gosu'
require_relative 'lib/color'
require_relative 'game'

class GameWindow < Gosu::Window
  def initialize
    @width = 500
    @height = 620
    super @width,@height, false # width, height, fullscreen
    self.caption = "Ruby Tetris" #caption
    @game = Game.new()
    @frame_count = 0
    @move_delay = 30
    @font = Gosu::Font.new(25,name: "Verdana", bold: true)
    @colors = Colors.new()
  end

  def update
    @frame_count += 1
    if (@frame_count % @move_delay == 0) && !@game.game_over
        @game.move_down()
    end
  end

  def draw()
    draw_background()
    score_group()
    next_block_group
    if @game.game_over
      game_over_screen()
    end
    @game.draw()

  end

  def score_group
    @font.draw_text("Score", 360, 10, 1, 1.0, 1.0, Colors::WHITE)
    Gosu.draw_rect(330, 40, 150, 50, Colors::LIGHT_BLUE)
    @font.draw_text(@game.score,390, 50,1, 1.0, 1.0, Colors::WHITE)
  end

  def next_block_group()
    @font.draw_text("Next", 360, 120, 1, 1.0, 1.0, Colors::WHITE)
    Gosu.draw_rect(330, 170, 150, 150, Colors::LIGHT_BLUE)
  end

  def game_over_screen()
    @font.draw_text("Game Over", 120, 230, 1, 2.0, 2.0, Colors::WHITE)
    @font.draw_text("Press R to restart", 150, 280, 1, 1.0, 1.0, Colors::WHITE)
    draw_quad(
      0,0, Gosu::Color.new(100, 0, 0, 0),
      @width,0, Gosu::Color.new(100, 0, 0, 0),
      @width,@height, Gosu::Color.new(100, 0, 0, 0),
      0,@height, Gosu::Color.new(100, 0, 0, 0),
    )
  end

  def button_down(id)
    
    case id
    when Gosu::KbLeft
      @game.move_left() 
    when Gosu::KbRight 
      @game.move_right() if !@game.game_over
    when Gosu::KbDown 
      @game.move_down() if !@game.game_over
      @game.update_score(0)
    when Gosu::KbSpace 
      @game.rotate() if !@game.game_over
    when Gosu::KbR 
      if @game.game_over
        @game.game_over = false
        @game.reset
      end
    end
  end


  def draw_background()
    background_color = Gosu::Color.new(255,44, 44, 127)
    draw_quad(
    0, 0, background_color, 
    @width, 0, background_color, 
    @width, @height, background_color, 
    0, @height, background_color)
  end
end

window = GameWindow.new
window.show