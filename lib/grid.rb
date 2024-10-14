require 'Gosu'
require_relative 'color'
class Grid
  attr_accessor :rows, :columns,:cell_size, :grid

  def initialize
    @rows = 20
    @columns = 10
    @cell_size = 30
    @grid = Array.new(@rows) { Array.new(@columns, 0) }
    @colors = Colors.get_cell_colors() #color array
    @linefinished_sound = Gosu::Sample.new("lib/sounds/linefinished.mp3")
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
        Gosu.draw_rect(j * @cell_size+301, i * @cell_size+11, @cell_size-1, @cell_size-1, color)
      end
    end
  end
  
  def is_inside?(row,col)
    if row >= 0 && row < @rows && col >= 0 && col < @columns
      return true
    else
      return false
    end
  end
  
  def is_row_full?(row)
    for cols in 0..@columns-1
      if @grid[row][cols] == 0
        return false
      end
    end
    return true
  end

  def clear_row(row)
    for cols in 0..@columns-1
      @grid[row][cols] = 0
    end
  end

  def move_down_rows(row,num_rows)
    for cols in 0..@columns-1
      @grid[row+num_rows][cols] = @grid[row][cols]
      @grid[row][cols] = 0
    end
  end

  def clear_full_rows()
    completed = 0 
    for row in (@rows-1).downto(0)
      if is_row_full?(row)
        @linefinished_sound.play()
        clear_row(row)
        completed += 1
      elsif completed > 0
        move_down_rows(row,completed)
      end
    end
    return completed
  end

  def is_empty?(row,col)
    if @grid[row][col] == 0
      return true
    else
      return false
    end
  end

  def reset #reset grid
    @grid.each { |row| row.fill(0) }
    @game_over = false 
  end
end