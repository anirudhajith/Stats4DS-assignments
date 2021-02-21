### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 85271884-705e-11eb-32ea-2ff05570364e
begin
	using Random
	using Plots
	pyplot()
end


# ╔═╡ 8c3409c0-705e-11eb-276d-5b115de5b8e0
cards = [1:52;]

# ╔═╡ a1f21afe-705e-11eb-307b-afb5b412cdb5
# Assume that cards 1 <= i <= 13 are spades
#                  14 <= i <= 26 are hearts
#                  27 <= i <= 39 are clubs
#                  40 <= i <= 52 are diamonds
# and i % 13 maps to A, 2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K.
# So a card is a Jack iff i % 13 == 11

# ╔═╡ a7a38ee0-7420-11eb-1a8b-23b15f7ed24c
md"#### Without replacement"

# ╔═╡ d1cb6428-705f-11eb-025f-bd9ca8e5ef22
begin
	num_trials = 100000000
	counts = [0, 0, 0, 0, 0, 0] 		# 0, 1, 2, 3, 4, 5
	Random.seed!(1)
	for _ in 1:num_trials
		cards1 = copy(cards)

		card1 = rand(cards1)
		deleteat!(cards1, findfirst(x-> x == card1, cards1))

		card2 = rand(cards1)
		deleteat!(cards1, findfirst(x-> x == card2, cards1))

		card3 = rand(cards1)
		deleteat!(cards1, findfirst(x-> x == card3, cards1))

		card4 = rand(cards1)
		deleteat!(cards1, findfirst(x-> x == card4, cards1))

		card5 = rand(cards1)
		deleteat!(cards1, findfirst(x-> x == card5, cards1))

		num_jacks = 0
		if card1 % 13 == 11
			num_jacks += 1
		end
		if card2 % 13 == 11
			num_jacks += 1
		end
		if card3 % 13 == 11
			num_jacks += 1
		end
		if card4 % 13 == 11
			num_jacks += 1
		end
		if card5 % 13 == 11
			num_jacks += 1
		end

		counts[num_jacks+1] += 1
	end
end


# ╔═╡ e9b266f2-740d-11eb-2d58-853933829251
plot(0:5, counts ./ num_trials, xlabel="number of jacks", ylabel="empirical probability", title="without replacement", legend=false)

# ╔═╡ dee3dcb4-71f7-11eb-33f2-0bea72639052
map(x->x/num_trials, counts)

# ╔═╡ 97a94b88-7420-11eb-28da-338be834db54
md"#### With replacement"

# ╔═╡ 54678cce-7420-11eb-0621-9d9feea4a3b8
begin
	num_trials2 = 100000000
	counts2 = [0, 0, 0, 0, 0, 0] 		# 0, 1, 2, 3, 4, 5
	Random.seed!(2)
	for _ in 1:num_trials
		cards12 = copy(cards)
		card12 = rand(cards12)
		card22 = rand(cards12)
		card32 = rand(cards12)
		card42 = rand(cards12)
		card52 = rand(cards12)

		num_jacks2 = 0
		if card12 % 13 == 11
			num_jacks2 += 1
		end
		if card22 % 13 == 11
			num_jacks2 += 1
		end
		if card32 % 13 == 11
			num_jacks2 += 1
		end
		if card42 % 13 == 11
			num_jacks2 += 1
		end
		if card52 % 13 == 11
			num_jacks2 += 1
		end

		counts2[num_jacks2+1] += 1
	end
end


# ╔═╡ 76ad7292-7420-11eb-3091-a9c5a330bee4
plot(0:5, counts2 ./ num_trials2, xlabel="number of jacks", ylabel="empirical probability", title="with replacement", legend=false)

# ╔═╡ 7c21133c-7420-11eb-3120-930b1b998645
map(x->x/num_trials2, counts2)

# ╔═╡ Cell order:
# ╠═85271884-705e-11eb-32ea-2ff05570364e
# ╠═8c3409c0-705e-11eb-276d-5b115de5b8e0
# ╠═a1f21afe-705e-11eb-307b-afb5b412cdb5
# ╟─a7a38ee0-7420-11eb-1a8b-23b15f7ed24c
# ╠═d1cb6428-705f-11eb-025f-bd9ca8e5ef22
# ╠═e9b266f2-740d-11eb-2d58-853933829251
# ╠═dee3dcb4-71f7-11eb-33f2-0bea72639052
# ╟─97a94b88-7420-11eb-28da-338be834db54
# ╠═54678cce-7420-11eb-0621-9d9feea4a3b8
# ╠═76ad7292-7420-11eb-3091-a9c5a330bee4
# ╠═7c21133c-7420-11eb-3120-930b1b998645
