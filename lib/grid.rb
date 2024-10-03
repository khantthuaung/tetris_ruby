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

  def draw() #draw each cell for corresponding color
    @grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        cell_value = @grid[i][j]
        color = @colors[cell_value]
        Gosu.draw_rect(j * @cell_size+1, i * @cell_size+1, @cell_size-1, @cell_size-1, color)
      end
    end
  end
  
  def is_inside?(row,col)
    if row >= 0 && row < @rows/2 && col >= 0 && col < @columns/2
      return true
    else
      return false
    end
  end

  def is_empty?(row,col)
    if @grid[row][col] == 0
      return true
    else
      return false
    end
  end
end