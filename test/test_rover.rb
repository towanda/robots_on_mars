require_relative File.join(%w(.. lib rover))
require 'minitest/autorun'
require 'minitest/pride'

class TestRover < MiniTest::Unit::TestCase

  def setup
    @rover = Rover.new
  end

  def test_default_position_is_0_0
    assert_equal "0 0 N", @rover.position
  end

  def test_default_orientation_is_north
    assert_equal "N", @rover.orientation
  end

  def test_rotate_right
    @rover.r
    assert_equal "E", @rover.orientation
  end

  def test_rotate_left
    @rover.l
    assert_equal "W", @rover.orientation
  end

  def test_move_when_orientation_is_north
    @rover.m
    assert_equal "0 1 N", @rover.position
  end

  def test_move_when_orientation_is_east
    @rover = Rover.new(0, 0, 'E')
    @rover.m
    assert_equal "1 0 E", @rover.position
  end

  def test_move_when_orientation_is_south
    @rover = Rover.new(0, 2, 'S')
    @rover.move
    assert_equal "0 1 S", @rover.position
  end

  def test_move_when_orientation_is_west
    @rover = Rover.new(2, 0, 'W')
    @rover.m
    assert_equal "1 0 W", @rover.position
  end

  def test_wont_move_out_of_lower_west_limit
    @rover = Rover.new(0, 0, 'W')
    @rover.m
    assert_equal "0 0 W", @rover.position
  end

  def test_wont_move_out_of_lower_south_limit
    @rover = Rover.new(0, 0, 'S')
    @rover.m
    assert_equal "0 0 S", @rover.position
  end

  def test_wont_move_out_of_upper_east_limit
    @rover = Rover.new(5, 5, 'E')
    @rover.m
    assert_equal "5 5 E", @rover.position
  end

  def test_wont_move_out_of_upper_north_limit
    @rover = Rover.new(5, 5,  'N')
    @rover.m
    assert_equal "5 5 N", @rover.position
  end

  def test_first_rover_process_instructions
    @rover = Rover.new(1, 2, 'N')
    @rover.process(["L", "M", "L", "M", "L", "M", "L", "M", "M"])
    assert_equal "1 3 N", @rover.position
  end

  def test_second_rover_process_instructions
    @rover = Rover.new(3, 3, 'E')
    @rover.process(["M", "M", "R", "M", "M", "R", "M", "R", "R", "M"])
    assert_equal "5 1 E", @rover.position
  end
end


