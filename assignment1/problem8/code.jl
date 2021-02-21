### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ ae94a9ea-7381-11eb-06d8-03520cc84ce7
begin
	using Random
	using Plots
	using Distributions
	pyplot()
end

# ╔═╡ e064c41e-7381-11eb-24f0-87a447340886
num_trials = 10000000

# ╔═╡ 4f5b7dc6-7383-11eb-336d-693c68d70892
begin
	results = Dict()
	for p in 0:0.1:1
		Random.seed!(2)
		num_profit = 0
		num_survive = 0
		for _ in 1:num_trials
			path = rand(Bernoulli(p), 20)
			balance = 10

			for i in 1:20
				if (path[i] == true)
					balance -= 1
				else
					balance += 1
				end
				
				if balance <= 0
					break
				end
			end

			if balance > 0
				num_survive += 1
			end
			
			if balance >= 10
				num_profit += 1
			end
		end

		results[p] = num_profit / num_survive
	end
end

# ╔═╡ ccd4c1ac-7385-11eb-3229-b7a4062fcb62
results

# ╔═╡ 446f7dc4-73a4-11eb-0204-9bc9d700f48a
plot(results, legend=true, xlabel="p", ylabel="P(having >= Rs. 10 | no bankruptcy)", label="empirical")

# ╔═╡ Cell order:
# ╠═ae94a9ea-7381-11eb-06d8-03520cc84ce7
# ╠═e064c41e-7381-11eb-24f0-87a447340886
# ╠═4f5b7dc6-7383-11eb-336d-693c68d70892
# ╠═ccd4c1ac-7385-11eb-3229-b7a4062fcb62
# ╠═446f7dc4-73a4-11eb-0204-9bc9d700f48a
