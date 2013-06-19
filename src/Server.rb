	
	#Class Server: It Holds the task during the service
	#
	#
class Server

	def initialize(newServiceRate,newSink)
		@serviceRate = newServiceRate
		@task = nil
		@attendedTasks = 0
		@sink = newSink
		@serviceTime = RandomTime.new("Exponential",@serviceRate)
		@busy = false
	end

	def free()
		@task.departureTime = System.time 
		@sink.dispatch(@task)
		@task = nil
		@attendedTasks += 1
		switchState()
	end

	def service(newTask)
		@task = newTask
		@task.startServiceTime = System.time
		switchState()
		@serviceTime.generateValues(1)
		#animation
	end

	def shouldFree?
		return false unless System.time - @task.startServiceTime >= @serviceTime.list.pop
		return true
	end

	def busy?
		return @busy
	end

	def switchState
		@busy = !@busy
	end

	def update
		if busy?
			if shouldFree?
				free()
				#animation here
			end
		end
	end
	def attendedTasks
		@attendedTasks
	end
end

