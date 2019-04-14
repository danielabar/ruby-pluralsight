require_relative "../lib/module7"
include Module7

describe Spaceship, "#name" do
  it "returns the name" do
    ship = Spaceship.new("Serenity")
    ship.name.should eq("Serenity")
  end
end