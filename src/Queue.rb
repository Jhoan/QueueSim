
	#Class Queue:
	#
	# => Params:
	# 						newSink: Where should the tasks go
	# 						newCapacity: How many tasks can exists in the queue
	# 						numServers: Number of servers available to the queue
	# 						attentionPolicy: How should the queue decide where to send a task when multiple servers are available
	# 							possible values: "Fastest", "Random", "First", "Least"
	# 						serviceRates: Specifies the service rates of each server
	# 						TODO: Server Names
class Queue
	def initialize(newSink, newCapacity, globalServiceRate, numServers, attentionPolicy = "Fastest Free Server",serviceRates = [])
		@tasks = Array.new
		@sink = newSink
		@capacity = newCapacity
		@numServers = numServers
		@attentionPolicy = attentionPolicy
		@servers = Array.new
		numServers.times do |i|
			if serviceRates[i].nil?
				servers.push Server.new(globalServiceRate,@sink)
			else
				servers.push Server.new(serviceRates[i],@sink)
			end
		end
	end

	def leastUsedFreeServer
		least = 0
		for i in 1..@numServers-1 do
			if @servers[i].attendedTasks < @servers[least].attendedTasks
				least = i
			end
		end
		return @servers[least]
	end

	def fastestFreeServer
		fastest = 0
		for i in 1..@numServers-1 do
			if @servers[i].serviceRate < @servers[fastest].serviceRate
				fastest = i
			end
		end
		return @servers[fastest]
	end

	def firstFreeServer
		@servers.each { |server| return server if !@server.busy? }
	end

	def randomFreeServer
		begin
			i = Random.rand(0..@numServers-1)
		end while @servers[i].busy?
		return @servers[i]
	end

	def idleServers
		count = 0
		@servers.each { |server| count += 1 if !server.busy? }
		return count
	end

	def length
		return @tasks.length
	end

	def full?
		if @length == @capacity
			return true
		else
			return false
		end
	end


	def update()
		return if @length == 0 || @idleServers == 0
		limit = @length
		limit = @idleServers if @idleServers < limit

		case @attentionPolicy
			when "Fastest"
				limit.times do
					fastestFreeServer.service(@tasks.pop())
				end
			when "Least"
				limit.times do
					leastUsedFreeServer.service(@tasks.pop())
				end
			when "Random"
				limit.times do
					randomFreeServer.service(@tasks.pop())
				end
			else
				limit.times do 
					firstFreeServer.service(@tasks.pop())
				end
		end
	end

end