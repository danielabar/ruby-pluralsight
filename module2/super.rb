class Probe
  def deploy(_deploy_time, _return_time)
    puts "Deploying"
  end
end

class MineralProbe < Probe
  def deploy(deploy_time)
    puts "Preparing sample chamber"
    super(deploy_time, Time.now + 2 * 60 * 60) # invokes deploy method from Probe base class
  end
end

MineralProbe.new.deploy(Time.now)
# Preparing sample chamber
# Deployingv