### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 823e2344-7363-11eb-0df2-d97957ae2b72
begin
	using Random
	using Plots
	using Distributions
	pyplot()
end

# ╔═╡ 5d56f0e6-7364-11eb-353e-294f2bbfdf56
md"#### Without replacement"

# ╔═╡ 6786b290-7364-11eb-3c6a-15a7f812ae61
begin
	# Wikipedia notation
	N1 = 52
	K1 = 4
	n1 = 5
	
	# Julia notation
	s1 = 4
	f1 = 48
	n1 = 5
	
	theoretical_without = pdf(Hypergeometric(s1, f1, n1))
end

# ╔═╡ 81b82c6a-740f-11eb-059c-39bbd83a69de
empirical_without = [0.658849, 0.299451, 0.0399469, 0.00173472, 1.788e-5]

# ╔═╡ 98fc7e26-740f-11eb-2e11-5371ffd8f465
begin
	plot(0:4, empirical_without, legend=true, xlabel="number of jacks", ylabel="probability", label="empirical", title="without replacement")
	plot!(0:4, theoretical_without, label="theoretical")
end


# ╔═╡ a67e4574-7366-11eb-0753-6b35058a7bc0
md"#### With replacement"

# ╔═╡ b50cc638-7366-11eb-3876-4d2eaba409cc
begin
	# Wikipedia notation
	n2 = 5
	p2 = 4/52
	
	# Julia notation
	n2 = 5
	p2 = 4/52
	
	theoretical_with = pdf(Binomial(n2, p2))
end

# ╔═╡ 2a4b8958-7410-11eb-2e4c-65972fc3c333
empirical_with = [0.670191, 0.27922, 0.046539, 0.00388536, 0.00016215, 2.54e-6]

# ╔═╡ 4e08a3a2-7411-11eb-2335-3971f9c44af1
begin
	plot(0:5, empirical_with, legend=true, xlabel="number of jacks", ylabel="probability", label="empirical", title="with replacement")
	plot!(0:5, theoretical_with, label="theoretical")
end


# ╔═╡ Cell order:
# ╠═823e2344-7363-11eb-0df2-d97957ae2b72
# ╠═5d56f0e6-7364-11eb-353e-294f2bbfdf56
# ╠═6786b290-7364-11eb-3c6a-15a7f812ae61
# ╠═81b82c6a-740f-11eb-059c-39bbd83a69de
# ╠═98fc7e26-740f-11eb-2e11-5371ffd8f465
# ╟─a67e4574-7366-11eb-0753-6b35058a7bc0
# ╠═b50cc638-7366-11eb-3876-4d2eaba409cc
# ╠═2a4b8958-7410-11eb-2e4c-65972fc3c333
# ╠═4e08a3a2-7411-11eb-2335-3971f9c44af1
