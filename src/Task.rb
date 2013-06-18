
	#Class: Task, Container for the tasks info.
	#
	#
	class Task 
		def initialize(newTime)
			@times = {'arrival' => newTime , 'startService' => nil, 'departure' => nil}
		end

		def arrivalTime
			@times['arrival']
		end

		def startServiceTime
			@times['startService']
		end

		def departureTime
			@times['departure']
		end

		def startServiceTime=(newTime)
			@times['startService'] = newTime
		end

		def departureTime=(newTime)
			@times['departure'] = newTime

	end