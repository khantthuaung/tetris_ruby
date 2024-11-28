require 'Gosu'
require_relative '../color'
require_relative 'button'

class Menu 
  attr_accessor :game_state
  def initialize(window, change_stage)
    @window = window
    @change_stage = change_stage
    @start = Button.new("Start",300, 250, 200, 50)
    
    @level_easy = Button.new("Easy",300,250 , 200, 50)
    @level_normal = Button.new("Normal",300,320 , 200, 50)
    @level_hard = Button.new("Hard",300,390, 200, 50)

    @options = Button.new("Options",300, 460, 200, 50)
    @quit = Button.new("Quit",300, 530, 200, 50)

    @title = Gosu::Font.new(80, name:"lib/fonts/ThaleahFat.ttf")
    @background_image = Gosu::Image.new("lib/images/background.png", tileable: true)
    lock_file = File.expand_path("../../images/lock.png", __FILE__)
    @lock = Gosu::Image.new(lock_file, tileable: true)
    score_file_path = File.expand_path("../../max_score.txt", __FILE__)
    if score_file_path
      score = File.read(score_file_path).chomp
      # Convert score content to an integer or default to 0 if it’s nil
      @max_score = score.to_i
    end
  end

  def update(mouse_x, mouse_y)
    @start.update(mouse_x, mouse_y)
    @options.update(mouse_x, mouse_y)
    @quit.update(mouse_x, mouse_y)
    @level_easy.update(mouse_x, mouse_y)
    if @max_score >= 500
      @level_normal.update(mouse_x, mouse_y)
    end
    if @max_score >= 1000
      @level_normal.update(mouse_x, mouse_y)
      @level_hard.update(mouse_x, mouse_y)
    end
  end

  def draw
    @background_image.draw(0, 0, 0)
    @title.draw("TETRIS", 250 , 100, 2, 1.5, 1, Colors::TITLE) 
    @level_easy.draw()
    @level_normal.draw()
    @level_hard.draw()
    @options.draw()
    @quit.draw()
    if @max_score < 500
      @lock.draw(300, 390, 1)
      @lock.draw(300, 460, 1)
    elsif @max_score < 1000
      @lock.draw(300, 460, 1)
    end
  end

  def click
    @options.click do
      Gosu::Sample.new("lib/sounds/button.mp3").play
      @change_stage.call(:options)
    end
    @quit.click do
      Gosu::Sample.new("lib/sounds/button.mp3").play
      exit
    end
    @level_easy.click do
      Gosu::Sample.new("lib/sounds/button.mp3").play
      @change_stage.call(:game)
    end
    @level_normal.click do
      @window.set_game_speed(15)
      Gosu::Sample.new("lib/sounds/button.mp3").play
      @change_stage.call(:game)
    end
    @level_hard.click do
      @window.set_game_speed(10)
      Gosu::Sample.new("lib/sounds/button.mp3").play
      @change_stage.call(:game)
    end
  end

end