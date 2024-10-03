require_relative 'color'
require 'Gosu'
class Block
  attr_accessor :block_id,:cells, :cell_size, :rotation_state
  def initialize (block_id)
    @block_id = block_id
    @cells = {}
    @cell_size = 40
    @rotation_state = 0
    @color = Colors.get_cell_colors()
  end

  def draw()
    tiles = @cells[@rotation_state]
    tiles.each do |tile|
      Gosu.draw_rect(tile.cols * @cell_size+1, tile.rows * @cell_size+1, @cell_size-1, @cell_size-1, @color[@block_id])
    end
  end
end
