class RandomTimes
	def initialize(size,distro,params)
		if distro == "Exponential" && params['lambda'] == nil
			raise "You need to provide a lambda parameter to generate Exponential values"
		end
		@distro = distro
		@list = Array.new()
		@params = params
		generateValues(size)
	end

	def generateValues(size)
		size.times do 
			case @distro
			when "Exponential" 
				@list.push( ((-1 * Math.log( Random.rand() ) ) / @params['lambda'] * 100).floor / 100.0)
			else
				@list.push(Random.rand())
			end

		end
	end
	def distro
		@distro
	end
	def list
		@list
	end
end
#test
params = { 'lambda' => 2}
t = RandomTimes.new(10000,"Exponential", params)
File.open("test.txt", "w") do |file| 
	t.list.each do |number|
		file.puts number
	end
end