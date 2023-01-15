n = 100
k = zeros(n)
v = zeros(n)
e = zeros(n)

for i = 1:n
k[i] = i
v[i] = (1+1/i)^i
e[i] = exp(1)
end

using Plots
scatter(k,v,xlabel = "freq of compounding" , ylabel = "value",ylims=(0,3))
scatter!(k,e)




savefig("C:\\Users\\willf\\OneDrive\\桌面\\hw1.png")
