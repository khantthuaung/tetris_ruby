require 'Gosu'
require_relative 'lib/color'
require_relative 'game'
require_relative 'lib/interfaces/options'
require_relative 'lib/interfaces/main_menu'
require_relative 'lib/interfaces/button'

class GameWindow < Gosu::Window
  def initialize
    @reset_button = Button.new(300, 300, 200, 50, "Reset")
    @width = 800
    @height = 680
    super @width,@height, false # width, height, fullscreen
    self.caption = "Ruby Tetris" #caption
    @game = Game.new()
    @font = Gosu::Font.new(30, name:"lib/fonts/ThaleahFat.ttf")
    @colors = Colors.new()
    @blocks = [IBlock.new(), JBlock.new(), LBlock.new(), OBlock.new(), SBlock.new(), TBlock.new(), ZBlock.new(),Ublock.new()]
  end
   
  def update
      @game.game_speed()
        #to keep pressing the button down
      if !@game.game_over
        if button_down?(Gosu::KbDown)
          @game.move_down
          @game.update_score(0) 
        end
      end
  end

  def show_timer()
    @font.draw_text("Time Elapsed", 620, 450, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.time[0]} : #{@game.time[1]}",670, 500, 1,1.0, 1.0, Colors::LIGHT_BLUE)
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
      if block.hidden_id==6
        block.draw(5,column+30)
        column += 80
      else
      block.draw(5,column)
      column += 80
      end
    end
    @font.draw_text("Blocks Appear Count", 30, 10, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[5]}", 250, 80, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[2]}", 250, 160, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[0]}", 250, 230, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[6]}", 250, 310, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[3]}", 250, 380, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[1]}", 250, 480, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[4]}", 250, 560, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[7]}", 250, 630, 1, 1.0, 1.0, Colors::WHITE)
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
    @font.draw_text("Game Over", 280, 230, 1, 2.0, 2.0, Colors::WHITE)
    @font.draw_text("Press R to restart", 290, 280, 1, 1.0, 1.0, Colors::WHITE)
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
      @game.move_left() if !@game.game_over
    when Gosu::KbRight
      @game.move_right()  if !@game.game_over
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
