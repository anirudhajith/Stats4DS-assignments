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

# ╔═╡ 8a5a42ee-7e47-11eb-3888-dd605db3d5c9
begin
	dict1 = [
		"religion" => ["Agnostic", "Atheist", "Buddhist", "Catholic", "Don't know/refused", "Evangelical Prot", "Hindu", "Historically Black Prot", "Jehovah's Witness", "Jewish"],
		
		"<\$10k" => [27, 12, 27, 418, 15, 575, 1, 228, 20, 19],
		
		"\$10-20k" => [34, 27, 21, 617, 14, 869, 9, 255, 27, 19],
		
		"\$20-30k" => [60, 37, 30, 732, 15, 1064, 7, 236, 24, 25],
		
		"\$30-40k" => [81, 52, 34, 670, 11, 982, 9, 238, 24, 25],
		
		"\$40-50k" => [76, 35, 33, 638, 10, 881, 11, 197, 21, 30],
		
		"\$50-75k" => [137, 70, 58, 1116, 35, 1486, 34, 223, 30, 95],
		
		"\$75-100k" => [140, 67, 69, 1206, 40, 1239, 45, 240, 31, 102],
		
		"\$100-150k" => [155, 58, 73, 1289, 42, 1065, 23, 232, 29, 257],
		
		">\$150k" => [130, 63, 80, 1065, 45, 897, 35, 250, 36, 202],
		
		"Don't know/refused" => [61, 58, 21, 567, 43, 769, 29, 132, 21, 106]
		
	]
	df1 = DataFrame(dict1)
	
	df1
end

# ╔═╡ 0b5892d4-7e4c-11eb-2638-4bc905b29372
begin 
	df2 = DataFrames.stack(df1, ["<\$10k", "\$10-20k", "\$20-30k", "\$30-40k", "\$40-50k", "\$50-75k", "\$75-100k", "\$100-150k", ">\$150k",	"Don't know/refused"])
	df3 = sort(select(df2, "religion", "variable" => "income", "value" => "freq"), ["religion"])
end

# ╔═╡ 1551ca8e-8d2a-11eb-144e-0fb0455de8a2
df666 = DataFrames.stack(df1, :)

# ╔═╡ ad49e122-7e64-11eb-327c-ed59d19360b0
md"""
#### Problem 2
"""

# ╔═╡ b59a52e2-7e64-11eb-2244-4f6397cb9e81
begin
	dict2 = [
		"id" => ["MX17004", "MX17004", "MX17004", "MX17004", "MX17004", "MX17004", "MX23048", "MX23048", "MX29057", "MX29057", "MX29057", "MX29057"],

		"year" => [2010, 2010, 2010, 2010, 2011, 2011, 2012, 2012, 2013, 2013, 2013, 2013],

		"month" => [1, 1, 5, 5, 4, 4, 9, 9, 11, 11, 12, 12],

		"element" => ["tmax", "tmin", "tmax", "tmin", "tmax", "tmin", "tmax", "tmin", "tmax", "tmin", "tmax", "tmin"],

		"d1" => [missing, missing, 27.6, 23.5, missing, missing, missing, missing, 23.3, 21.6, missing, missing],

		"d2" => [28.7, 26.4, missing, missing, missing, missing, 26.7, 25.4, missing, missing, missing, missing],

		"d3" => [missing, missing, missing, missing, 24.6, 23.5, 28.9, 28.8, missing, missing, missing, missing],

		"d4" => [missing, missing, missing, missing, 26.5, 26.4, missing, missing, missing, missing, missing, missing],

		"d5" => [32.5, 30.8, 31.5, 31.4, missing, missing, missing, missing, missing, missing, 24.5, 23.4],

		"d6" => [26.5, 21.3, missing, missing, 28.9, 27.6, missing, missing, missing, missing, 29.8, 27.6],

		"d7" => [missing, missing, missing, missing, missing, missing, 31.5, 31.2, 35.3, 31.8, missing, missing],

		"d8" => [missing, missing, 21.4, 18.6, missing, missing, missing, missing, missing, missing, missing, missing]

	]
	
	df4 = DataFrame(dict2)
end

# ╔═╡ ba0eb8f0-7e68-11eb-2229-5d4fc16d5c95
begin
	df5 = DataFrames.stack(df4, ["d1", "d2", "d3", "d4", "d5", "d6", "d7", "d8"])
	df6 = unstack(df5, ["id", "year", "month", "variable"], "element", "value")
	df7 = select(df6, "id", AsTable(["year", "month", "variable"]) => ByRow(x -> string(x.year, "-", x.month < 10 ? "0" : "", x.month, "-0", x.variable[2])) => "date", "tmax", "tmin")
	df8 = df7[completecases(df7), :]
end

# ╔═╡ 0130d444-7e6d-11eb-2d4e-cfd52b4d013d
md"""
#### Problem 3
"""

# ╔═╡ 376e137c-7e70-11eb-027e-8f154d44c15b
begin
	dict3 = [
    "year" => [2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2000, 2002, 2002, 2002, 2002, 2002],

    "artist" => ["2 Pac", "2 Pac", "2 Pac", "2 Pac", "2 Pac", "2 Pac", "2 Pac", "2Ge+her", "2Ge+her", "2Ge+her", "3 Doors Down", "3 Doors Down", "3 Doors Down", "3 Doors Down", "3 Doors Down"],

    "time" => ["4:22", "4:22", "4:22", "4:22", "4:22", "4:22", "4:22", "3:15", "3:15", "3:15", "3:53", "3:53", "3:53", "3:53", "3:53"],
    
    "track" => ["Baby Don't Cry", "Baby Don't Cry", "Baby Don't Cry", "Baby Don't Cry", "Baby Don't Cry", "Baby Don't Cry", "Baby Don't Cry", "The Hardest Part Of ...", "The Hardest Part Of ...", "The Hardest Part Of ...", "Kryptonite", "Kryptonite", "Kryptonite", "Kryptonite", "Kryptonite"],
    
    "date" => ["2000-02-26", "2000-03-04", "2000-03-11", "2000-03-18", "2000-03-25", "2000-04-01", "2000-04-08", "2000-09-02", "2000-09-09", "2000-09-16", "2002-04-08", "2002-04-15", "2002-04-22", "2002-04-29", "2002-05-06"],
    
    "week" => [1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 1, 2, 3, 4, 5],
    
    "rank" => [87, 82, 72, 77, 87, 94, 99, 91, 87, 92, 81, 70, 68, 67, 66]

]
	df9 = DataFrame(dict3)
end

# ╔═╡ 0a8c3068-7e72-11eb-342d-61829f2c3ff3
begin
	gd1 = groupby(df9, ["year", "artist", "time", "track"])
	df10 = DataFrame()
	for (id, sdf) in enumerate(gd1)
		df = DataFrame(sdf)
		insertcols!(df, 8, "id" => id)
		df10 = vcat(df10, df)
	end
	df11 = select(df10, "id", "artist", "track", "time")
	unique!(df11)
end

# ╔═╡ baa5078a-7e8e-11eb-20ee-27981e701127
df12 = select(df10, "id", "date", "rank")

# ╔═╡ a276e03a-7e92-11eb-3cac-e3ded5c61dd6
md"""
#### Problem 4
"""

# ╔═╡ dfebb4f8-7e93-11eb-1c98-51b4d82be4ca
results = JSON.parse(String(HTTP.request("GET", "https://api.covid19india.org/data.json"; verbose=0).body))["cases_time_series"]

# ╔═╡ 79436290-7e94-11eb-1a70-056f6c1e1264
begin
	df13 = DataFrame(dateymd = String[], date = String[], dailyconfirmed = Int[], dailydeceased = Int[], dailyrecovered = Int[], totalconfirmed = Int[], totaldeceased = Int[], totalrecovered = Int[])
	
	for result in results
		push!(df13, [result["dateymd"], result["date"], parse(Int, result["dailyconfirmed"]), parse(Int, result["dailydeceased"]), parse(Int, result["dailyrecovered"]), parse(Int, result["totalconfirmed"]), parse(Int, result["totaldeceased"]), parse(Int, result["totalrecovered"])])
	end
	
	df13
end

# ╔═╡ 844663ce-7e97-11eb-352a-c3a740b8b773
begin
	df14 = select(df13, "dateymd" => ByRow(x -> x[1:7]) => "dateym", "dailyconfirmed", "dailyrecovered", "dailydeceased")
	gd2 = groupby(df14, ["dateym"])
	combine(gd2, "dailyconfirmed" => sum => "totalconfirmed", "dailyrecovered" => sum => "totalrecovered", "dailydeceased" => sum => "totaldeceased")
end

# ╔═╡ e8742fd2-7e9b-11eb-1070-e781dcb53b49
md"""
#### Problem 5
"""

# ╔═╡ 67da8264-7e9d-11eb-1529-8381d031df6b
begin
	df15 = DataFrame(
		dateymd = String[],
		movingavgdailyconfirmed = Float64[],
		movingavgdailydeceased = Float64[],
		movingavgdailyrecovered = Float64[])
	
	for index in 7:nrow(df13)
		push!(df15, [
				df13[index, "dateymd"], 
				mean(eachrow(df13[index-6:index, "dailyconfirmed"]))[1], 
				mean(eachrow(df13[index-6:index, "dailydeceased"]))[1], 
				mean(eachrow(df13[index-6:index, "dailyrecovered"]))[1]
		])
	end
	
	df16 = outerjoin(df13, df15, on = "dateymd")
end


# ╔═╡ b44c48c2-7ea6-11eb-1a0e-fb8d27f3e4ab
begin
	fo = font(7, "Courier")
	fo.rotation = 90
end

# ╔═╡ 1541ab80-7ea8-11eb-0de1-17cee696677a
plot(df16[:,"dateymd"],df16[:,"dailyconfirmed"], xlabel="date", ylabel="daily confirmed", title="daily confirmed cases", xtickfont = fo, legend=false)

# ╔═╡ 28b1d078-7ea8-11eb-15db-413fdaf81425
plot(df16[:,"dateymd"],df16[:,"dailydeceased"], xlabel="date", ylabel="daily deceased", title="daily deceased cases", xtickfont = fo, legend=false)

# ╔═╡ 3ce774b2-7ea8-11eb-37d1-6d886b21c966
plot(df16[:,"dateymd"],df16[:,"dailyrecovered"], xlabel="date", ylabel="daily recovered", title="daily recovered cases", xtickfont = fo, legend=false)

# ╔═╡ 5fea376a-7ea8-11eb-3f37-276a97346d5e
plot(df16[:,"dateymd"],df16[:,"movingavgdailyconfirmed"], xlabel="date", ylabel="7 day moving average daily confirmed", title="7 day moving average daily confirmed cases", xtickfont = fo, legend=false, color="red")

# ╔═╡ 8a8e5e6a-7ea8-11eb-2c67-7366bffc2993
plot(df16[:,"dateymd"],df16[:,"movingavgdailydeceased"], xlabel="date", ylabel="7 day moving average daily deceased", title="7 day moving average daily deceased cases", xtickfont = fo, legend=false, color="red")

# ╔═╡ cd231f68-7ea8-11eb-3cc8-435f22c46e08
plot(df16[:,"dateymd"],df16[:,"movingavgdailyrecovered"], xlabel="date", ylabel="7 day moving average daily recovered", title="7 day moving average daily recovered cases", xtickfont = fo, legend=false, color="red")

# ╔═╡ Cell order:
# ╟─3fa395a8-7e46-11eb-00d8-9130e5665a36
# ╠═4d82bef8-7048-11eb-0e64-151cd8c80566
# ╟─838cfe16-7e47-11eb-3bfd-99ea084384f4
# ╟─8a5a42ee-7e47-11eb-3888-dd605db3d5c9
# ╠═0b5892d4-7e4c-11eb-2638-4bc905b29372
# ╠═1551ca8e-8d2a-11eb-144e-0fb0455de8a2
# ╟─ad49e122-7e64-11eb-327c-ed59d19360b0
# ╠═b59a52e2-7e64-11eb-2244-4f6397cb9e81
# ╠═ba0eb8f0-7e68-11eb-2229-5d4fc16d5c95
# ╟─0130d444-7e6d-11eb-2d4e-cfd52b4d013d
# ╠═376e137c-7e70-11eb-027e-8f154d44c15b
# ╠═0a8c3068-7e72-11eb-342d-61829f2c3ff3
# ╠═baa5078a-7e8e-11eb-20ee-27981e701127
# ╟─a276e03a-7e92-11eb-3cac-e3ded5c61dd6
# ╠═dfebb4f8-7e93-11eb-1c98-51b4d82be4ca
# ╠═79436290-7e94-11eb-1a70-056f6c1e1264
# ╠═844663ce-7e97-11eb-352a-c3a740b8b773
# ╟─e8742fd2-7e9b-11eb-1070-e781dcb53b49
# ╠═67da8264-7e9d-11eb-1529-8381d031df6b
# ╠═b44c48c2-7ea6-11eb-1a0e-fb8d27f3e4ab
# ╠═1541ab80-7ea8-11eb-0de1-17cee696677a
# ╠═28b1d078-7ea8-11eb-15db-413fdaf81425
# ╠═3ce774b2-7ea8-11eb-37d1-6d886b21c966
# ╠═5fea376a-7ea8-11eb-3f37-276a97346d5e
# ╠═8a8e5e6a-7ea8-11eb-2c67-7366bffc2993
# ╠═cd231f68-7ea8-11eb-3cc8-435f22c46e08
