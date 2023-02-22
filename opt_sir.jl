#=Angel Ortiz, A00828463@tec.mx
-04-2022=#

using Plots
plotlyjs()
x = nothing

function set_up()
    const t1 = 1000::Int64; t2 = 10000::Int64; dt = t1/t2
    const t = LinRange(0,t1,t2)
    const M = 0.0::Float64
    const S = 400.0::Float64
    const E = 50.0::Float64
    const I = 15.0::Float64
    const R = 0.0::Float64
    const N = M + S + E + I + R
    global x = zeros(Float64, length(t)::Int64, 6::Int64)


    const b = 0.003::Float64 #Tasa de natalidad
    const d = 0.002::Float64 #Tasa de mortalidad

    const β = 1.0::Float64 #Tasa de exposición
    const γ = 0.02::Float64 #Tasa de recuperación
    const δ = 1.0::Float64 #Tasa de susceptibilidad
    const ϵ = 0.15::Float64 #Tasa de infección
    const ζ = 0.1::Float64 #Resusceptibilidad
    const η = 0.0::Float64 #Vacunación

    global x[1, 1] = M; x[1, 2] = S; x[1, 3] = E; x[1, 4] = I; x[1, 5] = R; x[1, 6] = N
end

for u in range(2::Int64, stop=t2)
    x[u, 1] = x[u-1, 1] + (b*(x[u-1, 6] - x[u-1, 2]) - (δ+d)*x[u-1, 1])*dt
    x[u, 2] = x[u-1, 2] + (b*x[u-1, 2] + δ*x[u-1, 1] - β*x[u-1, 2]*x[u-1, 4]/x[u-1, 6] - d*x[u-1,2] + ζ*x[u-1,5])*dt
    x[u, 3] = x[u-1, 3] + (β*x[u-1, 2]*x[u-1, 4]/x[u-1, 6] - (ϵ+d)*x[u-1, 3])*dt
    x[u, 4] = x[u-1, 4] + (ϵ*x[u-1, 3] - (γ+d)*x[u-1, 4])*dt
    x[u, 5] = x[u-1, 5] + (γ*x[u-1, 4] - d*x[u-1, 5] - ζ*x[u-1, 5])*dt
    x[u, 6] = x[u-1, 6] + (b-d)*x[u-1, 6]*dt

    #= if x[u,4] > .4*x[u,6]
        x[u,2] = x[u,2] - η*x[u,2]
        x[u,1] = x[u,1] + η*x[u,2]
    end =#
    #= if x[u,5] > .7999999*x[u,6] && x[u,5] < .8000001*x[u,6]
        k = round(Int64,u/10)
        println("La pandemia acabó en el día $k")
    end =#
end


labels1 = ["Susceptibles" "Infectados" "Recuperados" "Inmunes" "Expuestos" "Población"]
plot(t, x[:, 1]./x[:, 6],
title = "Modelo MSEIRS",
label = labels1[4])
plot!(t, x[:, 2]./x[:, 6],
xlabel = "Tiempo (días)",
ylabel = "Población (personas)",
label = labels1[1])
plot!(t, x[:, 3]./x[:, 6],
label = labels1[5])
plot!(t, x[:, 4]./x[:, 6],
label = labels1[2])
plot!(t, x[:, 5]./x[:, 6],
label = labels1[3])
plot!(t, x[:, 6]/N,
label = labels1[6])

;