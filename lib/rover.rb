class Rover

  FACIN = %w(N E S W) # North, East, South, West

  def initialize(x= 0, y = 0, orientation = 'N', options = {})
    options = {limits: [5, 5]}.merge options
    @facin_index = FACIN.index orientation
    @x, @y = x.to_i, y.to_i
    @top_x, @top_y = options[:limits]
  end

  def orientation
    FACIN[@facin_index % 4]
  end

  def rotate_left; @facin_index -= 1; end

  def rotate_right; @facin_index += 1; end

  def move
    check_limits {|x, y| @x, @y = x, y }
  end

  def position
    "#{@x} #{@y} #{orientation}"
  end

  alias :r :rotate_right
  alias :l :rotate_left
  alias :m :move

  def process(instructions)
    instructions.each {|ins| send ins.downcase}
  end

  private

  def check_limits
    x, y  = send("move_#{orientation.downcase}")
    yield(x, y) if x.between?(0, @top_x) and y.between?(0, @top_y)
  end

  def move_north;  [@x, @y + 1]; end

  def move_west; [@x - 1, @y]; end

  def move_south; [@x, @y - 1]; end

  def move_east; [@x + 1, @y]; end

  alias :move_n :move_north
  alias :move_w :move_west
  alias :move_s :move_south
  alias :move_e :move_east
end
