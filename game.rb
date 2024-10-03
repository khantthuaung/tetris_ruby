require_relative 'lib/grid'
require_relative 'lib/tetrinominos'

class Game
  attr_accessor :grid, :block, :score, :game_over
  def initialize
    @grid = Grid.new()
    @blocks = [IBlock.new(), JBlock.new(), LBlock.new(), OBlock.new(), SBlock.new(), TBlock.new(), ZBlock.new()]
    @current_block = get_random_block()
    @next_block = get_random_block()
  end

  def get_random_block
    if @blocks.empty?
      @blocks = [IBlock.new(), JBlock.new(), LBlock.new(), OBlock.new(), SBlock.new(), TBlock.new(), ZBlock.new()]
    end
    block = @blocks.sample
    @blocks.delete(block)
    return block
  end

  def draw
    @grid.draw()
    @current_block.draw()
  end

  def move_left
    @current_block.move(0,-1)
    if block_inside() == false || block_fixed() == false
      @current_block.move(0,1)
    end
  end
  
  def move_right
    @current_block.move(0,1)
    if block_inside() == false || block_fixed() == false
      @current_block.move(0,-1)
    end
  end

  def move_down
    @current_block.move(1,0)
    if block_inside() == false || block_fixed() == false
      @current_block.move(-1,0)
      lock_block()
    end
  end

  def rotate
    @current_block.rotate()
    if block_inside() == false || block_fixed() == false
      @current_block.undo_rotation()
    end
  end

  def lock_block()
    tiles = @current_block.get_cell_position()
    tiles.each do |tile|
      @grid.grid[tile.rows][tile.cols] = @current_block.block_id
    end
    @current_block = @next_block
    @next_block = get_random_block()
  end
  
  def block_fixed()
    tiles = @current_block.get_cell_position()
    tiles.each do |tile|
      unless @grid.is_empty?(tile.rows, tile.cols)
        return false
      end
    end
    return true
  end

  def block_inside()
    tiles = @current_block.get_cell_position()
    tiles.each do |tile|
      if !@grid.is_inside?(tile.rows, tile.cols)
        return false
      end
    end
    return true
  end

  
end