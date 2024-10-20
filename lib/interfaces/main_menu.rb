require 'Gosu'
require_relative '../color'
require_relative 'button'

class Menu 
  attr_accessor :game_state
  def initialize(window, change_stage)
    @window = window
    @change_stage = change_stage
    @start = Button.new("Start",280, 300, 200, 50)
    @options = Button.new("Options",280, 370, 200, 50)
    @quit = Button.new("Quit",280, 440, 200, 50)
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
    @title.draw("TETRIS", 270, 100, 1, 1, 1, Gosu::Color::WHITE) 
    @start.draw()
    @options.draw()
    @quit.draw()
  end

  def click
    @start.click do
      @change_stage.call(:game)
    end
    @options.click do
      @change_stage.call(:options)
    end
    @quit.click do
      @window.close
    end
  end

end