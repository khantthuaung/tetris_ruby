require_relative 'lib/grid'
require_relative 'lib/tetrinominos'

class Game
  attr_accessor :grid, :block, :score, :game_over, :i_count, :j_count, :l_count, :o_count, :s_count, :z_count, :t_count
  def initialize
    @i_count = 0
    @j_count = 0
    @l_count = 0
    @o_count = 0
    @s_count = 0
    @z_count = 0
    @t_count = 0
    @grid = Grid.new()
    @blocks = [IBlock.new(), JBlock.new(), LBlock.new(), OBlock.new(), SBlock.new(), TBlock.new(), ZBlock.new()]
    @current_block = get_random_block()
    @next_block = get_random_block()
    @game_over = false
    @score = 0
    @gameover_sound = Gosu::Sample.new("sounds/gameover.mp3")
    @blockplaced_sound = Gosu::Sample.new("sounds/placed.mp3")
    @rotate_sound = Gosu::Sample.new("sounds/rotate.mp3")
    @gameover_sound = Gosu::Sample.new("sounds/gameover2.mp3")
  end

  def get_random_block
    if @blocks.empty?
      @blocks = [IBlock.new(), JBlock.new(), LBlock.new(), OBlock.new(), SBlock.new(), TBlock.new(), ZBlock.new()]
    end
    block = @blocks.sample
    @blocks.delete(block)
    return block
  end

  def count_blocks(id)
    case id
    when 1
      @l_count += 1
    when 2
      @t_count += 1
    when 3
      @j_count += 1
    when 4 
      @s_count += 1
    when 5
      @z_count += 1
    when 6
      @i_count += 1
    when 7
      @o_count += 1
    end
    

    puts "I: #{@i_count} J: #{@j_count} L: #{@l_count} O: #{@o_count} S: #{@s_count} T: #{@t_count} Z: #{@z_count}"
  end

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
  end

  def draw
    # @grid.print_grid()
    @grid.draw()
    # index = 0
    # while index < 7
    #   @block.draw(100,300)
    #   index+=1
    # end
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
  
  def reset
    @grid.reset()
    @blocks = [IBlock.new(), JBlock.new(), LBlock.new(), OBlock.new(), SBlock.new(), TBlock.new(), ZBlock.new()]
    @current_block = get_random_block()
    @next_block = get_random_block()
    @score = 0
    @i_count = 0
    @j_count = 0
    @l_count = 0
    @o_count = 0
    @s_count = 0
    @z_count = 0
    @t_count = 0

  end
end