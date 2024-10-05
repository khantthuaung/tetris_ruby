require 'gosu'
class Colors
    DARK_GREY = Gosu::Color.new(255, 26,31,40)
    GREEN = Gosu::Color.new(255, 47,230,23)
    RED = Gosu::Color.new(255, 232,18,18)
    ORANGE = Gosu::Color.new(255, 226,116,17)
    YELLOW = Gosu::Color.new(255, 237,234,4)
    PURPLE = Gosu::Color.new(255, 166,0,247)
    CYAN = Gosu::Color.new(255, 21,204,209)
    BLUE = Gosu::Color.new(255, 13,64,216)
    LIGHT_BLUE =  Gosu::Color.new(255, 128, 191, 255)
    WHITE = Gosu::Color.new(255, 255, 255, 255)

    def self.get_cell_colors()
        return [DARK_GREY,GREEN, RED, ORANGE, YELLOW, PURPLE, CYAN, BLUE]
    end
end