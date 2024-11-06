require 'Gosu'
require_relative '../color'
require_relative 'button'

class Menu 
  attr_accessor :game_state
  def initialize(window, change_stage)
    @window = window
    @change_stage = change_stage
    @start = Button.new("Start",300, 300, 200, 50)
    @options = Button.new("Options",300, 370, 200, 50)
    @quit = Button.new("Quit",300, 440, 200, 50)
    @title = Gosu::Font.new(80, name:"lib/fonts/ThaleahFat.ttf")
    @background_image = Gosu::Image.new("lib/background.png", tileable: true)
  end

  def update(mouse_x, mouse_y)
    @start.update(mouse_x, mouse_y)
    @options.update(mouse_x, mouse_y)
    @quit.update(mouse_x, mouse_y)
  end

  def draw
    @background_image.draw(0, 0, 0)
    @title.draw("TETRIS", 250 , 100, 2, 1.5, 1, Colors::TITLE) 
    @start.draw()
    @options.draw()
    @quit.draw()
  end

  def click
    @start.click do
      Gosu::Sample.new("lib/sounds/button.mp3").play
      @change_stage.call(:game)
    end
    @options.click do
      Gosu::Sample.new("lib/sounds/button.mp3").play
      @change_stage.call(:options)
    end
    @quit.click do
      Gosu::Sample.new("lib/sounds/button.mp3").play
      @window.close
    end
  end

end