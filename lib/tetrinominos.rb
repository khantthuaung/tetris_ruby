require_relative 'block'
require_relative 'color'
require_relative 'position'

class LBlock < Block
  def initialize
    @hidden_id= 1
    id = [1,2,3,4,5,6,7]
    super(@block_id = id.sample,@hidden_id)
    @cells = {
      0=> [Position.new(0,2),Position.new(1,0),Position.new(1,1),Position.new(1,2)],
      1=> [Position.new(0,1),Position.new(1,1),Position.new(2,1),Position.new(2,2)],
      2=> [Position.new(1,0),Position.new(1,1),Position.new(1,2),Position.new(2,0)],
      3=> [Position.new(0,0),Position.new(0,1),Position.new(1,1),Position.new(2,1)]
    }
    move(0,3)
  end
end

class TBlock < Block
  def initialize
    @hidden_id= 2
    id = [1,2,3,4,5,6,7]
    super(@block_id = id.sample,@hidden_id)
    @cells = {
      0=> [Position.new(0,1),Position.new(1,0),Position.new(1,1),Position.new(1,2)],
      1=> [Position.new(0,1),Position.new(1,1),Position.new(1,2),Position.new(2,1)],
      2=> [Position.new(1,0),Position.new(1,1),Position.new(1,2),Position.new(2,1)],
      3=> [Position.new(1,0),Position.new(0,1),Position.new(1,1),Position.new(2,1)]
    }
    move(0,3)
  end
end

class JBlock < Block
  def initialize
    @hidden_id= 3
    id = [1,2,3,4,5,6,7]
    super(@block_id = id.sample,@hidden_id)
    @cells = {
      0=> [Position.new(0,0),Position.new(1,0),Position.new(1,1),Position.new(1,2)],
      1=> [Position.new(0,1),Position.new(1,1),Position.new(2,0),Position.new(2,1)],
      2=> [Position.new(0,1),Position.new(0,2),Position.new(1,1),Position.new(2,1)],
      3=> [Position.new(1,0),Position.new(1,1),Position.new(1,2),Position.new(2,2)]
    }
  move(0,3)
  end
end

class SBlock < Block  
  def initialize
    @hidden_id= 4
    id = [1,2,3,4,5,6,7]
    super(@block_id = id.sample,@hidden_id)
    @cells = {
      0=> [Position.new(0,1),Position.new(0,2),Position.new(1,0),Position.new(1,1)],
      1=> [Position.new(0,0),Position.new(1,0),Position.new(1,1),Position.new(2,1)],
      2=> [Position.new(1,1),Position.new(1,2),Position.new(2,0),Position.new(2,1)],
      3=> [Position.new(0,1),Position.new(1,1),Position.new(1,2),Position.new(2,2)]
  }
  move(0,3)
  end
end

class ZBlock < Block
  def initialize
    @hidden_id= 5
    id = [1,2,3,4,5,6,7]
    super(@block_id = id.sample,@hidden_id)
    @cells = {
      0=> [Position.new(0,0),Position.new(0,1),Position.new(1,1),Position.new(1,2)],
      1=> [Position.new(0,1),Position.new(1,0),Position.new(1,1),Position.new(2,0)],
      2=> [Position.new(1,0),Position.new(1,1),Position.new(2,1),Position.new(2,2)],
      3=> [Position.new(0,2),Position.new(1,1),Position.new(1,2),Position.new(2,1)]
    }
    move(0,3)
  end
end

class IBlock < Block
  def initialize
    @hidden_id= 6
    id = [1,2,3,4,5,6,7]
    super(@block_id = id.sample,@hidden_id)
    @cells = {
      0=> [Position.new(1,0),Position.new(1,1),Position.new(1,2),Position.new(1,3)],
      1=> [Position.new(0,2),Position.new(1,2),Position.new(2,2),Position.new(3,2)],
      2=> [Position.new(2,0),Position.new(2,1),Position.new(2,2),Position.new(2,3)],
      3=> [Position.new(0,1),Position.new(1,1),Position.new(2,1),Position.new(3,1)]
  }
  move(-1,3)
  end
end

class OBlock < Block
  def initialize
    @hidden_id= 7
    id = [1,2,3,4,5,6,7]
    super(@block_id = id.sample, @hidden_id)
    @cells = {
      0=> [Position.new(0,0),Position.new(0,1),Position.new(1,0),Position.new(1,1)],
      1=> [Position.new(0,0),Position.new(0,1),Position.new(1,0),Position.new(1,1)],
      2=> [Position.new(0,0),Position.new(0,1),Position.new(1,0),Position.new(1,1)],
      3=> [Position.new(0,0),Position.new(0,1),Position.new(1,0),Position.new(1,1)]
  }
  move(0,4)
  end
end

class Ublock < Block
  def initialize
    @hidden_id= 8
    id = [1,2,3,4,5,6,7]
    super(@block_id = id.sample, @hidden_id)
    @cells = {
        0=> [Position.new(0,0),Position.new(0,1),Position.new(0,2),Position.new(1,0),Position.new(1,2)],
        1=> [Position.new(0,0),Position.new(0,1),Position.new(1,0),Position.new(2,0),Position.new(2,1)],
        2=> [Position.new(1,0),Position.new(1,2),Position.new(2,0),Position.new(2,1),Position.new(2,2)],
        3=> [Position.new(0,1),Position.new(0,2),Position.new(1,2),Position.new(2,1),Position.new(2,2)]
  }
  move(0,3)
  end

end

