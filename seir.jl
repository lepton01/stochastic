#Angel Ortiz, A00828463@itesm.mx

#import Pkg; #(1)
#Pkg.add("Plots"); #(1)
#Pkg.add("BenchmarkTools"); #(2)

using Plots #(1)
using BenchmarkTools #(2)
plotlyjs() #(1*)
x = nothing

t1 = 90::Int64; t2 = 90::Int64; dt = t1/t2
t = LinRange(0,t1,t2)
M = 0.0::Float64
S = 995.0::Float64
E = 0.0::Float64
I = 5.0::Float64
R = 0.0::Float64
N = M + S + E + I + R
x = zeros(Float64,length(t)::Int64,6::Int64)


α = .5::Float64 # Tasa de exposición
β = .8::Float64 # Tasa de infección
γ = (1/10)::Float64 # Tasa de recuperación



x[1,1] = M; x[1,2] = S; x[1,3] = E; x[1,4] = I; x[1,5] = R; x[1,6] = N
for u in range(2::Int64,stop=t2)
    
    x[u,2] = x[u-1,2] + (-α*x[u-1,2]*x[u-1,4]/x[u-1,6])*dt
    x[u,3] = x[u-1,3] + (α*x[u-1,2]*x[u-1,4]/x[u-1,6] - β*x[u-1,3])*dt
    x[u,4] = x[u-1,4] + (β*x[u-1,3] - γ*x[u-1,4])*dt
    x[u,5] = x[u-1,5] + (γ*x[u-1,4])*dt
    x[u,6] = x[u-1,6]

    #=
    if x[u,4] > .4*x[u,6]
        x[u,2] = x[u,2] - η*x[u,2]
        x[u,1] = x[u,1] + η*x[u,2]
    end
    =#
    #=
    if x[u,5] > .7999999*x[u,6] && x[u,5] < .8000001*x[u,6]
        k = round(Int64,u/10)
        println("La pandemia acabó en el día $k")
    end
    =#
end

labels1 = ["Susceptibles" "Infectados" "Recuperados" "Inmunes" "Expuestos" "Población"]
plot(t,x[:,6]./N,
title = "Modelo SEIR",
label = labels1[6])
plot!(t,x[:,2]./x[:,6],
xlabel = "Tiempo (días)",
ylabel = "Población (personas)",
label = labels1[1])
plot!(t,x[:,3]./x[:,6],
label = labels1[5])
plot!(t,x[:,4]./x[:,6],
label = labels1[2])
plot!(t,x[:,5]./x[:,6],
label = labels1[3])
#plot!(t,x[:,6]/N,
#label = labels1[6])

#@benchmark opt_sir() #(2)

#savefig("SEIR2") #(3)
#f = floor(maximum(x[:,4]))

#=
(1) = necesario ejecutar la primera vez
(2) = si se desea conocer el rendimiento
(3) = si se desea almacenar la figura localmente, inserte el nombre que desee
=#