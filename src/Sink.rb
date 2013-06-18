	# 
	#Class: Sink. Handles the departures
	#
	#
require 'date'
class Sink

	def initialize()
		@info = Array.new()
	end

	def dispatch(task,time)
		@info.push ( [task.arrivalTime,task.startServiceTime, time ] )
	end

	def write()
		File.open("Simulation " + Time.now.strftime("%d/%m/%Y %H:%M") , "w") do |file|
			file.print "Arrival \t Start Service \t Departure \t\n"
			@info.each do |item| 
				file.print item[0] + "\t" + item[1] + "\t" + item[2] + "\n"
			end
		end
	end

end