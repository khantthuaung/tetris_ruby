require_relative 'color'
require 'Gosu'
class Block
  attr_accessor :block_id,:cells, :cell_size, :rotation_state,:hidden_id
  def initialize (block_id,h_id)
    @block_id = block_id
    @hidden_id = h_id
    @cells = {}
    @cell_size = 30
    @row_off = 0
    @col_off = 0
    @rotation_state = 0
    @color = Colors.get_cell_colors()
  end

  def draw(offset_x,offset_y)
    tiles = get_cell_position
    tiles.each do |tile|
      Gosu.draw_rect(offset_x+ tile.cols * @cell_size,offset_y+ tile.rows * @cell_size, @cell_size-1, @cell_size-1, @color[@block_id])
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
