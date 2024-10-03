class Colors
    @dark_grey = Gosu::Color.new(255, 26,31,40)
    @green = Gosu::Color.new(255, 47,230,23)
    @red = Gosu::Color.new(255, 232,18,18)
    @orange = Gosu::Color.new(255, 226,116,17)
    @yellow = Gosu::Color.new(255, 237,234,4)
    @purple = Gosu::Color.new(255, 166,0,247)
    @cyan = Gosu::Color.new(255, 21,204,209)
    @blue = Gosu::Color.new(255, 13,64,216)

    def self.get_cell_colors()
        return [@dark_grey, @green, @red, @orange, @yellow, @purple, @cyan, @blue]
    end
end