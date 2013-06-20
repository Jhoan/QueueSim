
	#Class Source: It manages the arrivals
	#
	#
class Source
	def initialize(queue, distribution, arrivalRate)
		@queue = queue
		@distribution = distribution
		@arrivalRate = arrivalRate
		@arrivalTime = RandomTime.new(@distribution,@arrivalRate)
		@arrived = 0
		@dropped = 0
		@timeWOArrival = 0
	end

	def shouldSend?
		@timeWOArrival >= arrivalTime.list.pop ? true : false
	end

	def canSend?
		!@queue.full?
	end

	def send
		@queue.receive(Task.new(System.time))
	end

	def update
		if shouldSend?
			if canSend?
				send
				@arrived += 1
				arrivalTime.generateValues(1)
				#animate
			else
				@dropped += 1
				#animate
			end
		end
	end

	def arrived
		@arrived
	end

	def dropped
		@dropped
	end
end
