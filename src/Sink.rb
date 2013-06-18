	# 
	#Class: Sink. Handles the departures
	#
	#
require 'date'
class Sink

	def initialize()
		@info = Array.new()
	end

	def dispatch(task)
		@info.push ( [task.arrivalTime,task.startServiceTime, task.departureTime] )
	end

	def write()
		File.open("Simulation " + Time.now.strftime("%d/%m/%Y %H:%M") , "w") do |file|
			file.print "Arrival \t Start Service \t Departure \t\n"
			@info.each do |task| 
				file.print task['arrival'] + "\t" + task['startService'] + "\t" + task['departure'] + "\n"
			end
		end
	end

end