require_relative File.join(%w(.. lib rover))
require_relative File.join(%w(.. lib nasa_station))
require 'minitest/autorun'
require 'minitest/pride'

class TestNasaStation < MiniTest::Unit::TestCase

  def setup
    @station = NasaStation.new
  end

  def test_that_it_assigns_upper_limits
    assert_equal [5,5], @station.upper_limits
  end

  def test_that_creates_a_queue_with_rovers
    assert_equal 2, @station.rovers_queue.size
  end

  def test_that_queue_has_firs_rover_initial_position
    assert_equal "1", @station.rovers_queue.first.x
    assert_equal "2", @station.rovers_queue.first.y
    assert_equal "N", @station.rovers_queue.first.orientation
  end

  def test_that_queue_has_firs_rover_instructions
    assert_equal "LMLMLMLMM", @station.rovers_queue.first.instructions.join
  end

  def test_that_queue_has_last_rover_initial_position
    assert_equal "3", @station.rovers_queue.last.x
    assert_equal "3", @station.rovers_queue.last.y
    assert_equal "E", @station.rovers_queue.last.orientation
  end

  def test_that_queue_has_last_rover_instructions
    assert_equal "MMRMMRMRRM", @station.rovers_queue.last.instructions.join
  end

  def test_that_sends_two_rovers
    @station.send_all_rovers
    assert_equal 2, @station.rovers_final_positions.size
  end

  def test_that_first_rover_position_is_ok
    @station.send_all_rovers
    assert_equal '1 3 N', @station.rovers_final_positions.first
  end
end
