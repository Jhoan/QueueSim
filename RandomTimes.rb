class RandomTimes
	def initialize(size,distro,params)
		if distro == "Exponential" && params['lambda'] == nil
			raise "You need to provide a lambda parameter to generate Exponential or Poisson distributed values"
		end
		if (distro == "Poisson" || distro == "Exponential") && params['lambda'] < 0
			raise "Lambda should be greater than 0"
		end
		@distro = distro
		@list = Array.new()
		@params = params
		@size = size
		generateValues()
	end

	def generateValues()
		@list.clear
		case @distro
			when "Exponential" 
				@size.times do
					@list.push(((-1 * Math.log( Random.rand() ) ) / @params['lambda'] * 100).floor / 100.0)
				end
			when "Poisson"	
				if @params['lambda'] < 30 #Small lambda, using Knoth algorithm
					l = Math.exp(-1*@params['lambda'])
					@size.times do
						k, p = 0 , 1
						begin
							k += 1
							p *= Random.rand()
						end while p > l
						@list.push(k-1)
					end
				else
					c = 0.767 - 3.36/@params['lambda']
					beta = Math::PI/Math.sqrt(3.0*@params['lambda'])
					alpha = beta*@params['lambda']
					k = Math.log(c) - @params['lambda'] - Math.log(beta)
					@size.times do
						begin
							u = Random.rand()
							x = (alpha - Math.log((1.0 - u)/u))/beta
							n = (x + 0.5).floor
							if (n < 0)
								continue
							end
							v = Random.rand()
							y = alpha - beta*x
							lhs = y + Math.log(v/(1.0 + Math.exp(y))**2)
							rhs = k + n*Math.log(@params['lambda']) - Math.lgamma(n+1)[0]
							if (lhs <= rhs)
								@list.push(n)
								break
							end
						end while true
					end
				end

			else 
				@size.times do
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
params = { 'lambda' => 40}
t = RandomTimes.new(5,"Poisson", params)
t.generateValues()
File.open("test.txt", "w") do |file| 
	t.list.each do |number|
		file.puts number
	end
end