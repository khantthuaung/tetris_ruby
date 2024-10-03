require_relative 'color'
require 'Gosu'
class Block
  attr_accessor :block_id,:cells, :cell_size, :rotation_state
  def initialize (block_id)
    @block_id = block_id
    @cells = {}
    @cell_size = 40
    @row_off = 0
    @col_off = 0
    @rotation_state = 0
    @color = Colors.get_cell_colors()
  end

  def draw()
    tiles = get_cell_position
    tiles.each do |tile|
      Gosu.draw_rect(tile.cols * @cell_size+1, tile.rows * @cell_size+1, @cell_size-1, @cell_size-1, @color[@block_id])
    end
  end

  def move(rows,columns)
    @row_off += rows
    @col_off += columns
  end

  def get_cell_position()
    tiles = @cells[@rotation_state]
    moved_tiles = []
    tiles.each do |tile|
      moved_tiles.push(Position.new(tile.rows + @row_off, tile.cols + @col_off))
    end
    return moved_tiles
  end

  def rotate()
    @rotation_state = (@rotation_state + 1) % 4
  end

  def undo_rotation()
    @rotation_state = (@rotation_state - 1) % 4
  end
end
