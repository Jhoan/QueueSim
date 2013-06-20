	
	#Class QSystem: Main container of the system
	#
	#
class QSystem
	@@time = 0
	def initialize(source,queue,sink)
		@source = source
		@queue = queue
		@sink = sink
		@n = 0
		@delta = .01
	end
	def time
		@@time
	end
	def update
		puts "=" * 10 + "Cycle #{@@time}"
		queue.update
		sources.update
		queue.update
		@@time += 1
	end
end