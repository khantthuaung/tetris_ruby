require 'Gosu'
require_relative 'lib/color'
require_relative 'game'

class GameWindow < Gosu::Window
  def initialize
    @width = 800
    @height = 650
    super @width,@height, false # width, height, fullscreen
    self.caption = "Ruby Tetris" #caption
    @game = Game.new()
    @frame_count = 0
    @move_delay = 30
    @font = Gosu::Font.new(25,name: "Verdana", bold: true)
    @colors = Colors.new()
    @blocks = [IBlock.new(), JBlock.new(), LBlock.new(), OBlock.new(), SBlock.new(), TBlock.new(), ZBlock.new()]
    @timer = Gosu.milliseconds
    
  end

  def update
    @frame_count += 1
    elapsed_time = Gosu.milliseconds - @timer
    @seconds = (elapsed_time / 1000) % 60 
    @minutes = (elapsed_time / 1000)/60
    if @seconds > 30 && !@game.game_over
      @move_delay = 20
    end
    if @minutes > 0 && @seconds > 0 && !@game.game_over
      @move_delay = 10
    end
    if @minutes > 1 && @seconds > 0 && !@game.game_over
      @move_delay = 5
    end
    if (@frame_count % @move_delay == 0) && !@game.game_over
        @game.move_down()
    end
  end

  def show_timer()
    @font.draw_text("Time Elapsed", 620, 450, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@minutes} : #{@seconds}",670, 500, 1,1.0, 1.0, Colors::LIGHT_BLUE)
  end

  def draw()
    draw_background()
    score_group()
    next_block_group()
    if @game.game_over
      game_over_screen()
    end
    block_draw()
    show_timer
    @game.draw()

  end

  def block_draw()
    column = 50
    @blocks.each do |block|
      block.draw(5,column)
      column += 80
    end
    @font.draw_text("Blocks Appear Count", 30, 10, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.i_count}", 250, 50, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.j_count}", 250, 160, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.l_count}", 250, 230, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.o_count}", 250, 310, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.s_count}", 250, 380, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.t_count}", 250, 480, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.z_count}", 250, 560, 1, 1.0, 1.0, Colors::WHITE)
  end

  def score_group
    @font.draw_text("Score", 660, 10, 1, 1.0, 1.0, Colors::WHITE)
    Gosu.draw_rect(630, 40, 150, 50, Colors::LIGHT_BLUE)
    @font.draw_text(@game.score,690, 50,1, 1.0, 1.0, Colors::WHITE)
  end

  def next_block_group()
    @font.draw_text("Next", 660, 120, 1, 1.0, 1.0, Colors::WHITE)
    Gosu.draw_rect(630, 170, 150, 150, Colors::LIGHT_BLUE)
  end

  def game_over_screen()
    @font.draw_text("Game Over", 320, 230, 1, 2.0, 2.0, Colors::WHITE)
    @font.draw_text("Press R to restart", 350, 280, 1, 1.0, 1.0, Colors::WHITE)
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