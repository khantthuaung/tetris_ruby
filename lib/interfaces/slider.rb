require 'Gosu'

class Slider
  attr_reader :x, :y, :width, :height, :min_volume, :max_volume
  def initialize(window,x,y,width,height)
    @window = window
    @x = x
    @y = y
    @width = width
    @height = height
    @min_volume = 0.0
    @max_volume = 1.0

    #current volume
    @current_volume = 0.5
    @handle_position = @x + ( @current_volume*width)

    #to detect the dragging the slider bar
    @dragging= false
  end

  def update(song)
    if @window.button_down?(Gosu::MsLeft) && mouse_over_handle?
      @dragging = true
      # puts "Dragging started!"
    end

    #if mouse is release, no dragging
    unless @window.button_down?(Gosu::MsLeft)
      @dragging = false
      # puts "Dragging stopped!"
    end

    #update the volume if dragging
    if @dragging
      @handle_position = [[@window.mouse_x, @x].max,@x + @width].min
      @current_volume = ((@handle_position - @x)/@width)
       song.volume = @current_volume
      # puts "Volume: #{@current_volume}"
    end
  end

  def mouse_over_handle?
    @window.mouse_x.between?(@handle_position-10, @handle_position+10) &&  @window.mouse_y.between?(@y-10, @y+10)
    # puts "Mouse over handle: #{over_handle}"
  end

  def draw()
    #draw the slider bar
    Gosu.draw_rect(@x, @y - @height / 4, @width, @height / 2, Gosu::Color::GRAY)
    #draw the handle
    Gosu.draw_rect(@handle_position - 10, @y - 10, 20, 20, Gosu::Color::CYAN)
  end
end