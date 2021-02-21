### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 4d82bef8-7048-11eb-0e64-151cd8c80566
begin
	using Random
	using Plots
	pyplot()
end


# ╔═╡ 8306cb38-7047-11eb-13f6-013e1b2bcbfa
begin
	Random.seed!(2)
	max_magnitude = 100
	picking_range = -max_magnitude:max_magnitude
	num_picks = 100000
	running_total = 0
	averages = []

	for pick in 1:num_picks
		running_total = running_total + rand(picking_range)
		push!(averages, running_total / pick)
	end
end

# ╔═╡ bbe55758-7047-11eb-0ab7-ed5cf5eeeb05
plot(averages, xlabel="number of trials", ylabel="mean of picks so far", legend=false)

# ╔═╡ Cell order:
# ╠═4d82bef8-7048-11eb-0e64-151cd8c80566
# ╠═8306cb38-7047-11eb-13f6-013e1b2bcbfa
# ╠═bbe55758-7047-11eb-0ab7-ed5cf5eeeb05
