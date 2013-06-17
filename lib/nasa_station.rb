class NasaStation

  attr_reader :upper_limits, :rovers_queue, :rovers_final_positions

  def initialize
    @input_file = open_input_file
    @upper_limits = get_upper_limits
    @rovers_queue = get_rovers_info
    @rovers_final_positions = []
  end

  def send_all_rovers
    @rovers_queue.each do |info|
       send_rover(info)
    end
  end

  def send_rover(info)
    rover = Rover.new(info.x, info.y, info.orientation, limits: @upper_limits)
    rover.process(info.instructions)
    @rovers_final_positions << rover.position
  end

  def write_final_positions
    output_file = File.new(File.join('data', 'output'), 'w+')
    @rovers_final_positions.each do |position|
      output_file.puts position
    end
  end

  private

  def open_input_file
    File.open(File.join('data', 'input'))
  end

  def get_upper_limits
    @input_file.readline.split.map(&:to_i)
  end

  RoverInfo = Struct.new(:x, :y, :orientation, :instructions)
  def get_rovers_info
    @input_file.lines.each_slice(2).map do |cell|
      x, y, orientation = cell[0].chomp.split(' ')
      RoverInfo.new(x, y, orientation, cell[1].chomp.chars.to_a)
    end
  end
end
