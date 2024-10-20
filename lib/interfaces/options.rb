require 'Gosu'
require_relative '../color'
require_relative 'slider'

class Options
  def initialize(window,sound,change_stage)
    @window = window
    @title = Gosu::Font.new(40, name:"lib/fonts/ThaleahFat.ttf")
    @font = Gosu::Font.new(20, name:"lib/fonts/ThaleahFat.ttf")
    @slider = Slider.new(@window,200,300,300,20)
    @background_sound = sound
    @change_stage = change_stage
    @background_image = Gosu::Image.new("lib/background.png", tileable: true)
    @sound_on = Gosu::Image.new("lib/images/sound-50.png")
    @sound_off = Gosu::Image.new("lib/images/no-sound-50.png")

    @music_on = Gosu::Image.new("lib/images/music-64.png")
    @music_off = Gosu::Image.new("lib/images/no-music-64.png")

    @main_menu = Button.new("Back to Menu",280, 370, 200, 50)
  end

  def update(mouse_x, mouse_y)
    @slider.update(@background_sound)
    @main_menu.update(mouse_x, mouse_y)
  end

  def draw()
    @background_image.draw(0, 0, 0)
    @title.draw("Options", 250, 40, 1, 1.0, 1.0, Gosu::Color::BLACK)
    @sound_on.draw(200, 200, 1)
    @music_on.draw(250, 200, 1)
    @slider.draw()
    @main_menu.draw()
    
  end

  def click()
    @main_menu.click do
      @change_stage.call(:menu)
    end
  end

end
