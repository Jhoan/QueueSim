
	#Class: Task, Container for the tasks info.
	#
	#
	class Task 
		def initialize(newTime)
			@arrivalTime = newTime
			@startServiceTime = nil
			@departureTime = nil
		end

		def arrivalTime
			@arrivalTime
		end

		def startServiceTime
			@startServiceTime
		end

		def departureTime
			@departureTime
		end

		def startServiceTime=(newTime)
			@startServiceTime = newTime
		end

		def departureTime=(newTime)
			@departureTime = newTime

	end