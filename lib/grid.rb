require 'Gosu'
class Grid
  attr_accessor :rows, :columns,:cell_size, :grid

  def initialize
    @rows = 40
    @columns = 20
    @cell_size = 25
    @grid = Array.new(@rows) { Array.new(@columns, 0) }
    @colors = get_cell_colors #color array
  end

  def print_grid #grid printing
    @grid.each do |row|
      puts row.join(' ')
    end
  end

  def get_cell_colors #returns an array of colors for blocks

    dark_grey = Gosu::Color.new(255, 26,31,40)
    green = Gosu::Color.new(255, 47,230,23)
    red = Gosu::Color.new(255, 232,18,18)
    orange = Gosu::Color.new(255, 226,116,17)
    yellow = Gosu::Color.new(255, 237,234,4)
    purple = Gosu::Color.new(255, 166,0,247)
    cyan = Gosu::Color.new(255, 21,204,209)
    blue = Gosu::Color.new(255, 13,64,216)

    return [dark_grey, green, red, orange, yellow, purple, cyan, blue]
  end

  def draw() #draw each cell for corresponding color
    @grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        cell_value = @grid[i][j]
        color = @colors[cell_value]
        Gosu.draw_rect(j * @cell_size+1, i * @cell_size+1, @cell_size-1, @cell_size-1, color)
      end
    end
  end
  
  def draw_rect(x, y, width, height, color,z=0)
    draw_quad(
    x, y, color,
    x + width, y, color,
    x + width, y + height, color,
    x, y + height, color,z)
  end
end