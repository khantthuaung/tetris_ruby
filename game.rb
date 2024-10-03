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
    if @blocks.length == 0
      @blocks = [IBlock.new(), JBlock.new(), LBlock.new(), OBlock.new(), SBlock.new(), TBlock.new(), ZBlock.new()]
    end
    return @blocks.sample
  end

  def draw
    @grid.draw()
    @current_block.draw()
  end

  def move_left
    @current_block.move(0,-1)
    unless block_inside() 
      @current_block.move(0,1)
    end
  end
  
  def move_right
    @current_block.move(0,1)
    unless block_inside() 
      @current_block.move(0,-1)
    end
  end

  def move_down
    @current_block.move(1,0)
    unless block_inside()
      @current_block.move(-1,0)
    end
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