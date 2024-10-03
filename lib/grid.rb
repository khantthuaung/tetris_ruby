require 'Gosu'
require_relative 'color'
class Grid
  attr_accessor :rows, :columns,:cell_size, :grid

  def initialize
    @rows = 40
    @columns = 20
    @cell_size = 40
    @grid = Array.new(@rows) { Array.new(@columns, 0) }
    @colors = Colors.get_cell_colors() #color array
  end

  def print_grid #grid printing
    @grid.each do |row|
      puts row.join(' ')
    end
  end

  def get_cell_colors #returns an array of colors for blocks

    

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
  
  # def draw_rect(x, y, width, height, color,z=0)
  #   draw_quad(
  #   x, y, color,
  #   x + width, y, color,
  #   x + width, y + height, color,
  #   x, y + height, color,z)
  # end
end