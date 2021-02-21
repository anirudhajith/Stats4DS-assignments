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
		num_successes = 0

		for _ in 1:num_trials
			path = rand(Bernoulli(p), 20)	
			balance = 10

			for i in 1:20
				if (path[i] == true)
					balance -= 1
				else
					balance += 1
				end
			end

			if balance >= 10
				num_successes += 1
			end
		end

		results[p] = num_successes / num_trials
	end
end

# ╔═╡ 1fbdf69a-739f-11eb-167e-07a8db269f99
begin
	theoretical_results = Dict()
	for p in 0:0.1:1
		theoretical_results[p] = sum(pdf(Binomial(20, 1-p))[11:21])
	end
end

# ╔═╡ ccd4c1ac-7385-11eb-3229-b7a4062fcb62
results

# ╔═╡ 8ffb4df2-73a1-11eb-104a-c93f4a87927b
theoretical_results

# ╔═╡ 81d2d2c6-739d-11eb-0755-2fc51bc2e3ba
begin
	plot(results, legend=true, xlabel="p", ylabel="P(having at least Rs. 10 after 20 days)", label="empirical")
	plot!(theoretical_results, label="theoretical")
end

# ╔═╡ Cell order:
# ╠═ae94a9ea-7381-11eb-06d8-03520cc84ce7
# ╠═e064c41e-7381-11eb-24f0-87a447340886
# ╠═4f5b7dc6-7383-11eb-336d-693c68d70892
# ╠═1fbdf69a-739f-11eb-167e-07a8db269f99
# ╠═ccd4c1ac-7385-11eb-3229-b7a4062fcb62
# ╠═8ffb4df2-73a1-11eb-104a-c93f4a87927b
# ╠═81d2d2c6-739d-11eb-0755-2fc51bc2e3ba
