using HTTP, CSV, DataFrames

data_url = "https://raw.githubusercontent.com/chu155447/futures-and-options/main/data.csv"

my_file = CSV.File(HTTP.get(data_url).body)
df = DataFrame(my_file)

#計算測值個數
n_day = nrow(df)  

#變數差分
delta_S = df[2:n_day,2] - df[1:n_day-1,2]
delta_F = df[2:n_day,3] - df[1:n_day-1,3]

#計算敘述統計量
using Statistics

#母體標準差與rho, hedge ratio
std_ds1 = std(delta_S, corrected = false)
std_df1 = std(delta_F, corrected = false)
cov1 = cov(delta_S, delta_F, corrected = false)
rho1 = cov1 / std_ds1 / std_df1
h1 = rho1 * std_ds1 / std_df1

#樣本標準差與rho, hedge ratio
std_ds2 = std(delta_S, corrected = true)
std_df2 = std(delta_F, corrected = true)
cov2 = cov(delta_S, delta_F, corrected = true)
rho2 = cov2 / std_ds2 / std_df2
h2 = rho2 * std_ds2 / std_df2

#利用迴歸計算hedge ratio
using GLM
mat = hcat(delta_S,delta_F)
data = DataFrame(delta_S = mat[:,1],delta_F = mat[:,2])
ols = lm(@formula(delta_S ~ delta_F), data)


println("母體標準差: ", std_ds1)
println("母體協方差: ", cov1)
println("母體相關係數: ", rho1)
println("母體 hedgeratio: ", h1)
println("樣本標準差: ", std_ds2)
println("樣本協方差: ", cov2)
println("樣本相關係數: ", rho2)
println("樣本 hedgeratio: ", h2)
