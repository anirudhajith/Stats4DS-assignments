### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 73747dce-8d5b-11eb-34de-498d09a94f30
begin
	using DataFrames
	using Plots
	plotly()
	using Random
	using Statistics
	using Distributions
end

# ╔═╡ c30d2318-8d60-11eb-1214-674c27f29946
begin
	Random.seed!(5)
	N = Normal(0,1)
	pop_mean = mean(N)
	total_sum = 0
	
	s_arr = []
	p_arr = []
	for _ in 1:100 
		vars = rand(N, 5)
		sample_mean = mean(vars)
		push!(s_arr, sum((vars .- sample_mean).^2))
		push!(p_arr, sum((vars .- pop_mean).^2))
	end
	
	#plot(1:100, s_arr, line=2, label="sum((x-x_)^2)", color=:red)
	#plot!(1:100, p_arr, line=2, label="sum((x-μ)^2)", color=:blue)
	plot(1:100, p_arr .- s_arr, line=2, label="sum((x-μ)^2) - sum((x-x_)^2)", color=:blue)
	
end

# ╔═╡ b46eee76-8d70-11eb-3e0f-ff6cdc5826b0
plot(1:100, p_arr .- s_arr, line=2, label="sum((x-μ)^2) - sum((x-x_)^2)", color=:blue)

# ╔═╡ Cell order:
# ╠═73747dce-8d5b-11eb-34de-498d09a94f30
# ╠═c30d2318-8d60-11eb-1214-674c27f29946
# ╠═b46eee76-8d70-11eb-3e0f-ff6cdc5826b0
