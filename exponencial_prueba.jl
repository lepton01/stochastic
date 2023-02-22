using Plots

dt = .01::Float64
t = LinRange(0,1000,100000)
y0 = 50.0::Float64
z0 = 7.0::Float64
y = zeros(Float64,length(t),1::Int64)
z = zeros(Float64,length(t),1::Int64)

α = .03::Float64
β = .00001::Float64
γ = .08::Float64
y[1] = y0
z[1] = z0
for u in range(2,stop=length(t))
    y[u] = y[u-1] + α*y[u-1]*dt - β*y[u-1]*z[u-1]
    z[u] = z[u-1] + β*y[u-1]*z[u-1]-γ*z[u-1]*dt
end

labels1 = ["Presa" "Depredador"]
plot(t,y,
title = "Modelo presa-depredador",
label = labels1[1])
plot!(t,z,
xlabel = "Tiempo",
ylabel = "Población",
label = labels1[2])