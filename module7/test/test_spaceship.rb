require "minitest/autorun"

require_relative "../lib/module7"
include Module7

class TestSpaceship < MiniTest::Unit::TestCase
  def setup
    @ship = Spaceship.new("Serenity")
  end

  def test_name
    assert(@ship.name == "Serenity")
  end

  def test_probes
    @ship.probes += [Probe.new, Probe.new]
    assert_equal(2, @ship.probes.size)
  end

  def test_instance
    assert_instance_of(Spaceship, @ship)
  end

  def test_exception
    assert_raises { nil.name }
  end

end