### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 720be206-abfb-11eb-1136-d1829b3e6139
begin
	using Random
	using Statistics
	using Distributions
	using PlutoUI
	using StatsBase
end


# ╔═╡ 909f5060-abfb-11eb-1be9-a14bf2355d91
md"""
### Imports
"""

# ╔═╡ a7df4196-abfb-11eb-2983-cd16d92938d3
md"""
### Problem 1
"""

# ╔═╡ b0981ab0-abfb-11eb-123c-8350fdf0f496
begin
	Random.seed!(54)
	fair_coin = Bernoulli(0.5)
	num_trials = 1000000
	num_success = 0
	for i in 1:num_trials
		tosses = rand(fair_coin, 50)
		num_success += (count(tosses) >= 30)
	end
	num_success/num_trials
end

# ╔═╡ a40d0566-abfe-11eb-0d21-a36f08e2ae77
begin
	binom = Binomial(50, 0.5)
	1 - cdf(binom, 29)
end

# ╔═╡ 69a4e662-ac00-11eb-15ce-2330e20a2235
begin
	normal = Normal(50 * mean(fair_coin), std(fair_coin) * sqrt(50))
	1 - cdf(normal, 29.5)
end

# ╔═╡ bf803098-ac08-11eb-3990-cf251863704d
md"""
### Problem 2
"""

# ╔═╡ d8722a84-ac08-11eb-0339-a1a0291147ee
begin
	Random.seed!(54)
	fair_coin2 = Bernoulli(0.59)
	num_trials2 = 1000000
	num_success2 = 0
	for i in 1:num_trials2
		tosses2 = rand(fair_coin2, 50)
		num_success2 += (count(tosses2) >= 30)
	end
	num_success2/num_trials2
end

# ╔═╡ c5b7b536-ac0c-11eb-2def-816b29204e61
begin
	binom2 = Binomial(50, 0.59)
	1 - cdf(binom2, 29)
end

# ╔═╡ b4ba7c5c-ac0d-11eb-3e90-c90532d49f00
md"""
### Problem 3
"""

# ╔═╡ f993819a-ac0f-11eb-3f4c-9df08b564d7c
@bind n html"<input type=range min=1 max=50>"

# ╔═╡ 06432f1a-ac10-11eb-06c4-df2116c3326e
n

# ╔═╡ bcdf4a16-ac0f-11eb-2ba2-7feaa560cb12
begin
	normal2 = Normal(100n, 30sqrt(n))
	1 - cdf(normal2, 3000)
end

# ╔═╡ 532f2510-ac11-11eb-0c4e-2964cb7743b5
md"""
### Problem 4
"""

# ╔═╡ 87fdc114-af44-11eb-3767-05338745f508
md"""
We derive expressions that relate the 4 moments (i.e mean, variance, skewness, kurtosis) of two independant variables X and Y to use as an inductive step to calculate moments of the resultant distributions after convolution.

```math
mean(X+Y)       = mean(X) + mean(Y) \\
```

```math
var(X+Y)        = var(X) + var(Y) \\
```

```math
skew(X+Y)       =  \dfrac{skew(X) \cdot var(X)^{1.5} + skew(Y) \cdot var(Y)^{1.5}}{(var(X) + var(Y))^{1.5}} \\
```

```math
kurt(X+Y)       = \dfrac{kurt(X) \cdot var(X)^2 + kurt(Y) \cdot var(Y)^2 + 6\cdot var(X) \cdot var(Y)}{(var(X) + var(Y))^2} 
```
"""

# ╔═╡ 65008222-ac11-11eb-2358-97b851a06ebd
begin
	function get_sum_moments(M1, M2)
		M = [0.0, 0.0, 0.0, 0.0]
		M[1] = M1[1] + M2[1]
		M[2] = M1[2] + M2[2]
		M[3] = (M1[3] * M1[2]^1.5 + M2[3] * M2[2]^1.5) / (M1[2] + M2[2])^1.5
		M[4] = (M1[4] * M1[2]^2 + M2[4] * M2[2]^2 + 6 * M1[2] * M2[2]) / (M1[2] + M2[2])^2

		return M
	end

	function check_passes(M)
		return (abs(M[3] - 0) <= 0.1) && (abs(M[4] - 3) <= 0.1)
	end
end

# ╔═╡ 6e898244-af45-11eb-029b-f17b2b9ea32a
function find_min_conv(M)
	num_conv = 1
	M_sum = copy(M)
	
	while !check_passes(M_sum) 
		M_sum = get_sum_moments(M_sum, M)
		num_conv += 1
	end
	
	return num_conv
end

# ╔═╡ 88525122-af47-11eb-0cd4-2bf728d2a30f
begin
	uniform = Uniform(0, 1)
	moments = [mean(uniform), var(uniform), skewness(uniform), kurtosis(uniform, false)]
	find_min_conv(moments)
end

# ╔═╡ 10b625ce-af49-11eb-09a3-0b2511029a29
begin
	bernoulli = Bernoulli(0.01)
	moments2 = [mean(bernoulli), var(bernoulli), skewness(bernoulli), kurtosis(bernoulli, false)]
	find_min_conv(moments2)
end

# ╔═╡ 3c1e4372-af49-11eb-3068-4181984479ec
begin
	bernoulli2 = Bernoulli(0.5)
	moments3 = [mean(bernoulli2), var(bernoulli2), skewness(bernoulli2), kurtosis(bernoulli2, false)]
	find_min_conv(moments3)
end

# ╔═╡ 4d0cf75a-af49-11eb-3ffb-a5e742c72aa2
begin
	chisq = Chisq(3)
	moments4 = [mean(chisq), var(chisq), skewness(chisq), kurtosis(chisq, false)]
	find_min_conv(moments4)
end

# ╔═╡ Cell order:
# ╟─909f5060-abfb-11eb-1be9-a14bf2355d91
# ╠═720be206-abfb-11eb-1136-d1829b3e6139
# ╟─a7df4196-abfb-11eb-2983-cd16d92938d3
# ╠═b0981ab0-abfb-11eb-123c-8350fdf0f496
# ╠═a40d0566-abfe-11eb-0d21-a36f08e2ae77
# ╠═69a4e662-ac00-11eb-15ce-2330e20a2235
# ╟─bf803098-ac08-11eb-3990-cf251863704d
# ╠═d8722a84-ac08-11eb-0339-a1a0291147ee
# ╠═c5b7b536-ac0c-11eb-2def-816b29204e61
# ╟─b4ba7c5c-ac0d-11eb-3e90-c90532d49f00
# ╠═06432f1a-ac10-11eb-06c4-df2116c3326e
# ╟─f993819a-ac0f-11eb-3f4c-9df08b564d7c
# ╠═bcdf4a16-ac0f-11eb-2ba2-7feaa560cb12
# ╟─532f2510-ac11-11eb-0c4e-2964cb7743b5
# ╟─87fdc114-af44-11eb-3767-05338745f508
# ╠═65008222-ac11-11eb-2358-97b851a06ebd
# ╠═6e898244-af45-11eb-029b-f17b2b9ea32a
# ╠═88525122-af47-11eb-0cd4-2bf728d2a30f
# ╠═10b625ce-af49-11eb-09a3-0b2511029a29
# ╠═3c1e4372-af49-11eb-3068-4181984479ec
# ╠═4d0cf75a-af49-11eb-3ffb-a5e742c72aa2
