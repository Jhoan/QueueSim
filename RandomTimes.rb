class RandomTimes
	def initialize(size,distro,lambda)
		if distro == "Exponential" && lambda == nil
			raise "You need to provide a lambda parameter to generate Exponential or Poisson distributed values"
		end
		if (distro == "Poisson" || distro == "Exponential") && lambda < 0
			raise "Lambda should be greater than 0"
		end
		if (distro == "Poisson" && lambda % 1 != 0)
			raise "Lambda should be an integer"
		end
		@distro = distro
		@list = Array.new()
		@lambda = lambda
		@size = size
		generateValues()
	end

	def generateValues()
		@list.clear
		case @distro
			when "Exponential" 
				@size.times do
					@list.push(((-1 * Math.log( Random.rand() ) ) / @lambda * 100).floor / 100.0)
				end
			when "Poisson"	
				if @lambda < 30 #Small lambda, using Knoth algorithm
					l = Math.exp(-1*@lambda)
					@size.times do
						k, p = 0 , 1
						begin
							k += 1
							p *= Random.rand()
						end while p > l
						@list.push(k-1)
					end
				else #Large Lambda, using Pa Algorithm
					c = 0.767 - 3.36/@lambda
					beta = Math::PI/Math.sqrt(3.0*@lambda)
					alpha = beta*@lambda
					k = Math.log(c) - @lambda - Math.log(beta)
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
							rhs = k + n*Math.log(@lambda) - Math.lgamma(n+1)[0]
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
	def getTMean
		case @distro 
			when "Exponential"
				@lambda**-1.to_f
			when "Poisson"
				@lambda
			else
				return 1/2
		end
	end
	def getRMean
		sum = 0
		@list.each { |n| sum+=n }
		sum/@size
	end
	def distro
		@distro
	end
	def list
		@list
	end
	def size
		@size
	end
end
#test
t = RandomTimes.new(1000,"Poisson", 10)
t.generateValues()
File.open("test.txt", "w") do |file| 
	t.list.each do |number|
		file.puts number
	end
end
puts t.getTMean
puts t.getRMean