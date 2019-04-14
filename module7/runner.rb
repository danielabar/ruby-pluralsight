require 'log4r'
include Log4r

mylog = Logger.new 'mylog'
mylog.outputters = Outputter.stdout

# Now we can log.
mylog.info "Runner is executing!"