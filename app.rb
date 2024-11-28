require './main'
require './game'
require './lib/interfaces/options'
require './lib/interfaces/main_menu'
require './lib/color'


class App < Gosu::Window
  attr_accessor :game_state,:timer,:game_speed
  def initialize()
    @game_state = :menu
    @game_speed = 30
    @menu = Menu.new(self,method(:change_stage))
    @game = GameWindow.new(@game_speed, method(:change_stage))
    @game_functions = Game.new()
    @background_sound = Gosu::Song.new("lib/sounds/intro.mp3")
    @background_sound.volume = 0.5
    @options = Options.new(self,@background_sound,method(:change_stage))
    super 800, 680
   
  end

  def update()
    case @game_state
    when :game
      @game.update(mouse_x,mouse_y)
      @background_sound.stop()
    when :menu
      @background_sound.play()
      @menu.update(mouse_x, mouse_y)
    when :options
      @options.update(mouse_x, mouse_y)
      @background_sound.play()
    end
  end
  def draw()
    case @game_state
      when :menu
        @menu.draw
      when :game
        @game.draw
      when :options
        @options.draw
    end
  end

  def button_down(id)
    # button down methods for each game state screen
    if id == Gosu::MsLeft
      case @game_state
      when :menu
        @menu.click
      when :options
        @options.click
      when :game
        @game.click
      end
    end

    case @game_state
    when :game
      @game.button_down(id)
    end

  end

  def change_stage(new_state)
    puts "Changing game state to: #{new_state}"
    @game_state = new_state
  end

  def set_game_speed(speed)
    puts "Game Speed set to: #{speed}"
    @game_speed = speed 
    @game.update_game_speed(speed)
  end
  
end

App.new.show