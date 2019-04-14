module Module7
  class Spaceship
    attr_accessor :name
    attr_accessor :probes

    def initialize(name)
      self.name = name
      self.probes = []
    end

    def launch
      batten_hatches
      puts "launching spaceship"
    end

    private

    def batten_hatches
      puts "battening hatches"
      hatches = [:port, :starboard, :aft]
      hatches.each do |hatch|
        puts "Shutting #{hatch} hatch"
      end
    end
  end
end
