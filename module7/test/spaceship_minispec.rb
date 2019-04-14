require "minitest/autorun"

require_relative "../lib/module7"
include Module7

describe Spaceship do
  before do
    @ship = Spaceship.new("Serenity")
  end

  describe "when asked for a name" do
    it "must provide one" do
      @ship.name.must_equal "Serenity"
    end
  end
end