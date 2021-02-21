### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ f51eb402-736b-11eb-216c-c550cc44f96f
begin
	using Random
	using Plots
	using Distributions
	pyplot()
end

# ╔═╡ 303b9e56-736c-11eb-2522-7d854664e81e
begin
	Random.seed!(2)
	
	T = randstring(['A':'Z'; 'a':'z'; '0':'9'; '~'; '!'; '@'; '#'; '$'; '%'; '^'; '&'; '*'; '('; ')'; '_'; '+'; '='; '-'; '`'; ],8) 			# true password
	
	num_trials = 1000000
	num_successes = 0
	
	for _ in 1:num_trials
		match_count = 0
		
		R = randstring(['A':'Z'; 'a':'z'; '0':'9'; '~'; '!'; '@'; '#'; '$'; '%'; '^'; '&'; '*'; '('; ')'; '_'; '+'; '='; '-'; '`'; ],8) 			# random password guess
		
		for i in 1:8
			if (T[i] == R[i])
				match_count += 1
			end
		end
		
		if (match_count >= 3)
			num_successes += 1
		end
		
	end
	
	num_successes
	
end

# ╔═╡ Cell order:
# ╠═f51eb402-736b-11eb-216c-c550cc44f96f
# ╠═303b9e56-736c-11eb-2522-7d854664e81e
