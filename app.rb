require './main'
require './lib/interfaces/options'
require './lib/interfaces/main_menu'
require './lib/color'


class App < Gosu::Window
  attr_accessor :game_state
  def initialize()
    @game_state = :menu
    @menu = Menu.new(self,method(:change_stage))
    @game = GameWindow.new
    @options = Options.new()
    super 800, 680
  end

  def update()
    case @game_state
    when :game
      @game.update
    when :menu
      @menu.update(mouse_x, mouse_y)
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
  
end

App.new.show