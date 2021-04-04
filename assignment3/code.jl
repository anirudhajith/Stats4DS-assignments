### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 4d82bef8-7048-11eb-0e64-151cd8c80566
begin
	using DataFrames
	using Random
	using Plots
	using HTTP
	using JSON
	using JSONTables
	using Statistics
	using Distributions
	using QuadGK
	using PlutoUI
	using StatsBase
	using CSV
	using Dates
	pyplot()
end


# ╔═╡ 3fa395a8-7e46-11eb-00d8-9130e5665a36
md"""
#### Imports
"""

# ╔═╡ 838cfe16-7e47-11eb-3bfd-99ea084384f4
md"""
#### Problem 1
"""

# ╔═╡ bc19415c-93a7-11eb-3115-c3466052eb41
function KLD(p, q, inf=37)
	function f(x) 
		if (p(x) == 0) || (q(x) == 0)
			return 0
		else 
			return p(x) * log(p(x)/q(x))
		end
	end
	return quadgk(f, -inf, inf)[1]
end

# ╔═╡ 4c06a2f8-93b4-11eb-0d03-eb5f4e32f80b
[KLD(x -> pdf(TDist(i), x), x -> pdf(Normal(0,1), x)) for i in 1:5]

# ╔═╡ ad49e122-7e64-11eb-327c-ed59d19360b0
md"""
#### Problem 2
"""

# ╔═╡ 3f267e0e-943c-11eb-3483-91ecc4c59053
function pdfnconv(n, npoints=100)
	function discrete_convolve(arr1, arr2, npoints=100)
		result = []
		for x in 0:1/npoints:10
			sum_ = 0


			for i in 0:1/npoints:10
				xminusi = round((x-i) * npoints) / npoints
				if (xminusi >= 0) && (xminusi <= 10)
					sum_ += arr1[i] * arr2[xminusi] * (1/npoints)
				end
			end
			push!(result, (x, sum_))
		end
		return Dict(result)
	end
	
	U = Dict([(x, pdf(Uniform(0,1), x)) for x in 0:1/npoints:10])
	distributions = [U]
	
	for times in 2:n
		push!(distributions, discrete_convolve(U, distributions[times-1], npoints))
	end
	
	function f_(x)
		if x < 0 || x > 10
			return 0.0
		else
			xround = round((x * npoints))/npoints
			return distributions[n][xround]
		end
	end
	
	return f_
end

# ╔═╡ a1d0eb22-9444-11eb-15b3-e36c0a1122b5
begin
	mean_(p) = quadgk(x -> x*p(x), 0, 10)[1]
	function variance_(p) 
		mu = mean_(p)
		return quadgk(x -> (x-mu)^2 * p(x), -0, 10)[1]
	end
	stdev_(p) = sqrt(variance_(p))
	kdivs = []
	
	for n in 1:10
		fx = pdfnconv(n, 1000)
		normal = Normal(mean_(fx), stdev_(fx))
		nx = x -> pdf(normal, x)
		#plot(fx, -10, 10, ylims=(0,1))
		#plot!(nx, -10, 10, ylims=(0,1))
		push!(kdivs, KLD(fx, nx, 10))
	end
	
	kdivs
end

# ╔═╡ 32fb470e-9450-11eb-3e4f-9da193839324
plot(kdivs, xlabel="Number of convolutions", ylabel="KL Divergence from normal of same μ, σ")

# ╔═╡ 0130d444-7e6d-11eb-2d4e-cfd52b4d013d
md"""
#### Problem 3
"""

# ╔═╡ d82cf9ee-945c-11eb-0b12-85c03378b95f
begin
	Random.seed!(14)
	arr = rand(Poisson(0.90), 10000)
end

# ╔═╡ f8b5bf90-945c-11eb-36e5-d90f7d937e28
mean(arr)

# ╔═╡ fc2efe46-945c-11eb-0be3-89e75c2e09f9
median(arr)

# ╔═╡ 096046ee-945d-11eb-09e7-91fecffaf8ae
skewness(arr)

# ╔═╡ d9ecce54-945d-11eb-3c6e-c97219602156
begin
	histogram(arr, xlabel="x", ylabel="pmf", label="pmf", title="Poisson (λ = 0.90)", bar_width=0.8)
	d_mode = mode(arr)
	d_median = median(arr)
	d_mean = mean(arr)
	height = count(x -> x == d_mode, arr) + 500
	plot!([d_mode, d_mode], [0, height], label="Mode", line=(2, :dash, :red))
	plot!([d_mean, d_mean], [0, height], label="Mean", line=(2, :dash, :orange))
	plot!([d_median, d_median], [0, height], label="Median", line=(2, :dash, :yellow))
end

# ╔═╡ a276e03a-7e92-11eb-3cac-e3ded5c61dd6
md"""
#### Problem 4
"""

# ╔═╡ 33da1d02-946a-11eb-1529-f924e7354425
begin
	Random.seed!(6)
	U4 = Uniform(0, 1)
	ranges = []
	for i in 1:10000
		sample = rand(U4, 30)
		push!(ranges, maximum(sample) - minimum(sample))
	end
	
	histogram(ranges, xlabel="ranges", ylabel="frequency", label="pmf", title="Distribution of ranges", legend=:topleft)
	d_mode4 = mode(ranges)
	d_median4 = median(ranges)
	d_mean4 = mean(ranges)
	height4 = count(x -> x == d_mode4, ranges) + 700
	plot!([d_mode4, d_mode4], [0, height4], label="Mode", line=(2, :dash, :red))
	plot!([d_mean4, d_mean4], [0, height4], label="Mean", line=(2, :dash, :orange))
	plot!([d_median4, d_median4], [0, height4], label="Median", line=(2, :dash, :yellow))
end

# ╔═╡ fe64c2ba-9470-11eb-0fe6-f7c41df24808
d_mean4, d_median4, d_mode4

# ╔═╡ e8742fd2-7e9b-11eb-1070-e781dcb53b49
md"""
#### Problem 5
"""

# ╔═╡ b9d50888-9530-11eb-2081-0b9fcfdc1b58
md"""
Proof in document
"""

# ╔═╡ d420206a-9530-11eb-00e8-11120545d717
md"""
#### Problem 6
"""

# ╔═╡ 1dbb5c3a-9531-11eb-2294-8bbe7caf210f
begin
	statewise_daily_table = CSV.File(HTTP.get("https://api.covid19india.org/csv/latest/state_wise_daily.csv").body)
	statewise_daily_df = DataFrame(statewise_daily_table)
end

# ╔═╡ b0394f28-9535-11eb-19d2-59046b6222d6
begin
	df2 = select(select(statewise_daily_df[(statewise_daily_df.Status .== "Confirmed"), :], Not(:TT)), Not(:Status))
	init_date = df2[1,"Date_YMD"]
	df3 = transform(df2, :Date_YMD => ByRow(x -> floor(Int64, Dates.value(x - init_date)/7)) => :WeekNumber)
	gdf = groupby(df3, :WeekNumber)
	df4 = combine(gdf, :AN => sum => :AN, :AP => sum => :AP, :AR => sum => :AR, :AS => sum => :AS, :BR => sum => :BR, :CH => sum => :CH, :CT => sum => :CT, :DN => sum => :DN, :DD => sum => :DD, :DL => sum => :DL, :GA => sum => :GA, :GJ => sum => :GJ, :HR => sum => :HR, :HP => sum => :HP, :JK => sum => :JK, :JH => sum => :JH, :KA => sum => :KA, :KL => sum => :KL, :LA => sum => :LA, :LD => sum => :LD, :MP => sum => :MP, :MH => sum => :MH, :MN => sum => :MN, :ML => sum => :ML, :MZ => sum => :MZ, :NL => sum => :NL, :OR => sum => :OR, :PY => sum => :PY, :PB => sum => :PB, :RJ => sum => :RJ, :SK => sum => :SK, :TN => sum => :TN, :TG => sum => :TG, :TR => sum => :TR, :UP => sum => :UP, :UT => sum => :UT, :WB => sum => :WB)
end

# ╔═╡ ccd5ec16-9537-11eb-100b-254db6af73bb
begin
	matrix = convert(Matrix,df4[:, Not(:WeekNumber)])
	covar = cov(matrix)
	pcorr = cor(matrix)
	scorr = StatsBase.corspearman(matrix)
end

# ╔═╡ 9f8c03c6-953c-11eb-2875-4393b64113f2
begin
	states = names(df4)[2:length(names(df4))]
	fo = font(7, "Courier")
	fo.rotation = 90
	heatmap(states, states, covar, xlabel="States", ylabel="States", title="Covariances of weekly new cases", xticks = (0.5:1:length(states)-0.5, states), yticks = (0.5:1:length(states)-0.5, states), xtickfont=fo, size=(1000, 800), c=:thermal)
end

# ╔═╡ ca300ca0-953f-11eb-0efa-7994db38e5db
heatmap(states, states, pcorr, xlabel="States", ylabel="States", title="Pearson's correlation coefficients for weekly new cases", xticks = (0.5:1:length(states)-0.5, states), yticks = (0.5:1:length(states)-0.5, states), xtickfont=fo, size=(800, 600), c=:thermal)

# ╔═╡ c536063c-953f-11eb-1374-659ad1a5afe5
heatmap(states, states, scorr, xlabel="States", ylabel="States", title="Spearman's correlation coefficients for weekly new cases", xticks = (0.5:1:length(states)-0.5, states), yticks = (0.5:1:length(states)-0.5, states), xtickfont=fo, size=(800, 600), c=:thermal)

# ╔═╡ f30ada7e-9553-11eb-3074-df8b90b1e058
begin
	plot(df4[:, :MH], label="Maharashtra", xlabel="week", ylabel="number of new cases", legend=:topleft)
	plot!(df4[:, :KA], label="Karnataka")
	plot!(df4[:, :KL], label="Kerala")
	plot!(df4[:, :LD], label="Lakshadweep")
	
	
end

# ╔═╡ 1157af8a-9544-11eb-028a-df9ee9255986
md"""
#### Problem 7
"""

# ╔═╡ 15095584-9544-11eb-18f8-9112d281fe05
function OneSidedTailN(x)
	normal7 = Normal(0,1)
	return percentile(normal7, 100-x)
end

# ╔═╡ d43acd88-9545-11eb-0a18-3d14b411ba09
function OneSidedTailT(x)
	tdist7 = TDist(10)
	return percentile(tdist7, 100-x)
end


# ╔═╡ 39e5df9c-9546-11eb-1ded-1778e1820235
begin
	normal7 = Normal(0,1)
	tdist7 = TDist(10)
	normal_out = OneSidedTailN(95)
	tdist_out = OneSidedTailT(95)
	plot(x -> pdf(normal7, x), label="Normal(0,1)", xlabel="x", ylabel="pdf", title="Normal(0,1) and TDist(10)")
	plot!(x -> pdf(tdist7, x), label="TDist(10)")
	plot!(x -> (x > normal_out) ? pdf(normal7, x) : 0, fillrange = 0, fillalpha=0.25, line=0, c=:cyan, label="OneSidedTailN(95)")
	plot!(x -> (x > tdist_out) ? pdf(tdist7, x) : 0, fillrange = 0, fillalpha=0.25, line=0, c=:red, label="OneSidedTailT(95)")
end

# ╔═╡ Cell order:
# ╟─3fa395a8-7e46-11eb-00d8-9130e5665a36
# ╠═4d82bef8-7048-11eb-0e64-151cd8c80566
# ╟─838cfe16-7e47-11eb-3bfd-99ea084384f4
# ╠═bc19415c-93a7-11eb-3115-c3466052eb41
# ╠═4c06a2f8-93b4-11eb-0d03-eb5f4e32f80b
# ╟─ad49e122-7e64-11eb-327c-ed59d19360b0
# ╠═3f267e0e-943c-11eb-3483-91ecc4c59053
# ╠═a1d0eb22-9444-11eb-15b3-e36c0a1122b5
# ╠═32fb470e-9450-11eb-3e4f-9da193839324
# ╟─0130d444-7e6d-11eb-2d4e-cfd52b4d013d
# ╠═d82cf9ee-945c-11eb-0b12-85c03378b95f
# ╠═f8b5bf90-945c-11eb-36e5-d90f7d937e28
# ╠═fc2efe46-945c-11eb-0be3-89e75c2e09f9
# ╠═096046ee-945d-11eb-09e7-91fecffaf8ae
# ╠═d9ecce54-945d-11eb-3c6e-c97219602156
# ╟─a276e03a-7e92-11eb-3cac-e3ded5c61dd6
# ╠═33da1d02-946a-11eb-1529-f924e7354425
# ╠═fe64c2ba-9470-11eb-0fe6-f7c41df24808
# ╟─e8742fd2-7e9b-11eb-1070-e781dcb53b49
# ╟─b9d50888-9530-11eb-2081-0b9fcfdc1b58
# ╟─d420206a-9530-11eb-00e8-11120545d717
# ╠═1dbb5c3a-9531-11eb-2294-8bbe7caf210f
# ╠═b0394f28-9535-11eb-19d2-59046b6222d6
# ╠═ccd5ec16-9537-11eb-100b-254db6af73bb
# ╠═9f8c03c6-953c-11eb-2875-4393b64113f2
# ╠═ca300ca0-953f-11eb-0efa-7994db38e5db
# ╠═c536063c-953f-11eb-1374-659ad1a5afe5
# ╠═f30ada7e-9553-11eb-3074-df8b90b1e058
# ╟─1157af8a-9544-11eb-028a-df9ee9255986
# ╠═15095584-9544-11eb-18f8-9112d281fe05
# ╠═d43acd88-9545-11eb-0a18-3d14b411ba09
# ╠═39e5df9c-9546-11eb-1ded-1778e1820235
