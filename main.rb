require 'Gosu'
require_relative 'lib/color'
require_relative 'game'
require_relative 'lib/interfaces/options'
require_relative 'lib/interfaces/main_menu'
require_relative 'lib/interfaces/button'

class GameWindow < Gosu::Window
  def initialize(move_delay, change_stage)
    @frame_count = 0
    @time = Array.new(2,0)
    @move_delay = move_delay
    @reset_button = Button.new("Restart",300, 440, 200, 50)
    @main_menu_btn = Button.new("Main Menu",300, 500, 200, 50)
    @exit_btn = Button.new("Exit Game",300, 560, 200, 50)
    @width = 800
    @height = 680
    @change_stage = change_stage
    super @width,@height, false # width, height, fullscreen
    self.caption = "Ruby Tetris" #caption
    @game = Game.new()
    @font = Gosu::Font.new(30, name:"lib/fonts/ThaleahFat.ttf")
    @colors = Colors.new()
    @pause = false
    @blocks = [IBlock.new(), JBlock.new(), LBlock.new(), OBlock.new(), SBlock.new(), TBlock.new(), ZBlock.new(),Ublock.new()]
  end
   
  def update(timer,mouse_x, mouse_y)
    @reset_button.update(mouse_x,mouse_y)
    @main_menu_btn.update(mouse_x, mouse_y)
    @exit_btn.update(mouse_x, mouse_y)
    
    if !@game.game_over and !@pause
      unless @pause
        elapsed_time = Gosu.milliseconds - timer - (@paused_duration || 0)
        if !@game.game_over
          @time[1]= (elapsed_time / 1000) % 60 
          @time[0]= (elapsed_time / 1000)/60
        end
      end
        game_speed(@move_delay)
        #to keep pressing the button down
        if !@game.game_over
          if button_down?(Gosu::KbDown)
            @game.move_down
            @game.update_score(0) 
          end
        end
    end
  end

  def show_timer()
    @font.draw_text("Time Elapsed", 620, 450, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@time[0]} : #{@time[1]}",670, 500, 1,1.0, 1.0, Colors::LIGHT_BLUE)
  end

  def draw()
    if @game.game_over
      game_over_screen()
    end
      draw_background()
      score_group()
      next_block_group()
      block_draw()
      show_timer
      @game.draw()
    
  end

  def block_draw()
      column = 50
    @blocks.each do |block|
      if block.hidden_id==6
        block.draw(0,column+30)
        column += 80
      else
      block.draw(0,column)
      column += 80
      end
    end
    @font.draw_text("Blocks Appear Count", 20, 10, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[5]}", 220, 80, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[2]}", 220, 160, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[0]}", 220, 230, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[6]}", 220, 310, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[3]}", 220, 380, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[1]}", 220, 480, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[4]}", 220, 560, 1, 1.0, 1.0, Colors::WHITE)
    @font.draw_text("#{@game.counter[7]}", 220, 630, 1, 1.0, 1.0, Colors::WHITE)
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

    if File.exist?("lib/max_score.txt")
      File.open("lib/max_score.txt",'r') do |file|
        @max_score = file.read.to_i
      end
    end
    highest = "Highest Score"
    game_over = "Game Over"
  

    @font.draw_text(game_over,( (@width-get_text_width(game_over))/2)-60, 50, 1, 2.0, 2.0, Colors::GAME_OVER)

    @font.draw_text(highest,(@width-get_text_width(highest))/2 , 280, 1, 1.0, 1.0, Colors::GAME_OVER)
    @font.draw_text(@max_score,(@width-get_text_width(@max_score))/2 ,300, 1, 1.0, 1.0, Colors::GAME_OVER)


    @reset_button.draw()
    @main_menu_btn.draw()
    @exit_btn.draw()
    draw_quad(
      0,0, Gosu::Color.new(100, 0, 0, 0.2),
      @width,0, Gosu::Color.new(100, 0, 0, 0.2),
      @width,@height, Gosu::Color.new(100, 0, 0, 0.2),
      0,@height, Gosu::Color.new(100, 0, 0, 0.2),
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
    when Gosu::KbP
      switch_pause_state
    when Gosu::MsLeft
      if @game.game_over
        @reset_button.click do
          @game.game_over = false
          @game.reset
        end
        @main_menu_btn.click do
          @game.game_over = false
          @game.reset
        end
        @exit_btn.click do
          close
        end
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

  def game_speed(speed)
    @frame_count += 1
    if (@frame_count % speed == 0) && !@game.game_over
        @game.move_down()
    end
  end


  def update_game_speed(new_speed)
    @move_delay = new_speed
  end

  def get_text_width(text)
    return @font.text_width(text)
  end

  def switch_pause_state
    if @pause == false
      @pause = true
      @pause_start = Gosu.milliseconds
    else
      @pause = false
      @paused_duration = (Gosu.milliseconds - @pause_start)
    end
  end

  def click()
    @reset_button.click do
      @game.game_over = false
      @game.reset
    end
    @main_menu_btn.click do
      @change_stage.call(:menu)
    end
    @exit_btn.click do
      close
    end
  end
end
