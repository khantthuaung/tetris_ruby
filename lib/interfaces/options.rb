require 'Gosu'
require_relative '../color'
require_relative 'slider'

class Options
  def initialize(window,sound,change_stage)
    @window = window
    @title = Gosu::Font.new(80, name:"lib/fonts/ThaleahFat.ttf")
    @font = Gosu::Font.new(30, name:"lib/fonts/ThaleahFat.ttf")
    @music_slider = Slider.new(@window,250,380,300,20)
    @background_sound = sound
    @change_stage = change_stage
    @background_image = Gosu::Image.new("lib/images/background.png")
    @music_control = false
    @main_menu = Button.new("Back to Menu",300, 450, 200, 50)
  end

  def update(mouse_x, mouse_y)
    @music_slider.update(@background_sound)
    @main_menu.update(mouse_x, mouse_y)
  end

  def draw()
    @background_image.draw(0, 0, 0)
    text_width = @title.text_width("Options")
    @title.draw("Options", (800-text_width)/2, 100, 1, 1.0, 1.0, Gosu::Color::YELLOW)
  
    @font.draw_text("Background Music", 290, 330, 1, 1.0, 1.0, Gosu::Color::GREEN)
    @music_slider.draw()

    @main_menu.draw()
    
  end

  def click()
    @main_menu.click do
      Gosu::Sample.new("lib/sounds/button.mp3").play
      @change_stage.call(:menu)
    end
  end
  
end
