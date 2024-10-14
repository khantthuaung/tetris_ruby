require 'Gosu'
class Button
  attr_reader :x, :y, :width, :height, :text

  def initialize(text, x, y, width, height)
    @text = Gosu::Font.new(30,name:"lib/fonts/ThaleahFat.ttf")
    @text_string = text
    @x, @y, @width, @height = x, y, width, height
    @hover = false
  end

  # Draw the button with a simple rectangle and text
  def draw
    color = @hover ? Gosu::Color::GRAY : Gosu::Color::WHITE
    Gosu.draw_quad(
      @x, @y, color,
      @x + @width, @y, color,
      @x + @width, @y + @height, color,
      @x, @y + @height, color
    )
    @text.draw_text(@text_string, @x + 60, @y + 10, 1, 1.0, 1.0, Gosu::Color::BLACK)
  end

  # Check if the mouse is over the button
  def hover?(mouse_x, mouse_y)
    mouse_x > @x && mouse_x < @x + @width && mouse_y > @y && mouse_y < @y + @height
  end

  # Set hover state and change color if hovered
  def update(mouse_x, mouse_y)
    @hover = hover?(mouse_x, mouse_y)
  end

  # Trigger the button action when clicked
  def click
    if @hover
      yield if block_given?
    end
  end
end