require_relative 'lib/grid'
require_relative 'lib/tetrinominos'

class Game
  attr_accessor :grid, :block, :score, :game_over, :counter , :time
  def initialize
    
    @counter = Array.new(8,0)
    
    @grid = Grid.new()
    @blocks = [IBlock.new(), JBlock.new(), LBlock.new(), OBlock.new(), SBlock.new(), TBlock.new(), ZBlock.new(),Ublock.new()]
    @current_block = get_random_block()
    @next_block = get_random_block()
    @game_over = false
    @score = 0
    @gameover_sound = Gosu::Sample.new("lib/sounds/gameover.mp3")
    @blockplaced_sound = Gosu::Sample.new("lib/sounds/placed.mp3")
    @rotate_sound = Gosu::Sample.new("lib/sounds/rotate.mp3") 
  end

  def get_random_block
    if @blocks.empty?
      @blocks = [IBlock.new(), JBlock.new(), LBlock.new(), OBlock.new(), SBlock.new(), TBlock.new(), ZBlock.new(),Ublock.new()]
    end
    block = @blocks.sample
    count_blocks(block.hidden_id)
    @blocks.delete(block)
    return block
  end

  #block counter for each block
  def count_blocks(id)
    index = 0
    total = 8 
    while index < total
      if index == id-1
        @counter[index] += 1
      end
      index += 1
    end
  end

  #scoore update
  def update_score(line_clear)
    if line_clear ==1 
      @score += 100
    elsif line_clear == 2
      @score += 300
    elsif line_clear == 3
      @score += 500
    elsif line_clear == 4
      @score += 1000
    end
    current_max_score = 0
    if File.exist?("lib/max_score.txt")
      File.open("lib/max_score.txt",'r') do |file|
        current_max_score = file.read.to_i
      end
    end

    #update score if the current score is greater than the max score
    if @score > current_max_score
      File.open("lib/max_score.txt", "w") do |file|
        file.write @score
      end
    end
  end

  #draw grid and blocks on the screen
  def draw
    # @grid.print_grid()
    @grid.draw()
    @current_block.draw(301,11)
    if @next_block.hidden_id ==6
      @next_block.draw(555,240)
    elsif  @next_block.hidden_id ==7
      @next_block.draw(555,220)
    else
      @next_block.draw(570,200)
    end
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
    @rotate_sound.play()
    if block_inside() == false || block_fixed() == false
      @current_block.undo_rotation()
    end
  end

  #place the block on the grid
  def lock_block()
    @blockplaced_sound.play()
    tiles = @current_block.get_cell_position()
    tiles.each do |tile|
      @grid.grid[tile.rows][tile.cols] = @current_block.block_id
    end
    @current_block = @next_block
    @next_block = get_random_block()
    rows_clear = @grid.clear_full_rows()
    update_score(rows_clear)

    if block_fixed() == false
      @gameover_sound.play()
      @game_over = true
    end
  end
  
  #check whether the block is fixed
  def block_fixed()
    tiles = @current_block.get_cell_position()
    tiles.each do |tile|
      unless @grid.is_empty?(tile.rows, tile.cols)
        return false
      end
    end
    return true
  end
   
  #check whether the block is inside the grid
  def block_inside()
    tiles = @current_block.get_cell_position()
    tiles.each do |tile|
      if !@grid.is_inside?(tile.rows, tile.cols)
        return false
      end
    end
    return true
  end
  
  def reset
    @grid.reset()
    @blocks = [IBlock.new(), JBlock.new(), LBlock.new(), OBlock.new(), SBlock.new(), TBlock.new(), ZBlock.new(),Ublock.new()]
    @current_block = get_random_block()
    @next_block = get_random_block()
    @score = 0
    @counter = Array.new(8,0)
    @timer = Gosu.milliseconds
  end

end