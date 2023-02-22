#Angel Ortiz, A00828463@itesm.mx

#import Pkg; #(1)
#Pkg.add("Plots"); #(1)
#Pkg.add("BenchmarkTools"); #(2)
using CairoMakie
function sirs()
    dt = 0.01::Float64
    t = 0:dt:100-dt
    M = 0.0::Float64
    S = 490.0::Float64
    E = 0.0::Float64
    I = 10.0::Float64
    R = 0.0::Float64
    N = M + S + E + I + R
    x = zeros(Float64, length(t), 6::Int)


    β = 0.2::Float64 # Tasa de infección
    γ = (1/210)::Float64 # Tasa de recuperación
    ζ = 0.0::Float64 # Resusceptibilidad


    x[1, 1] = M
    x[1, 2] = S
    x[1, 3] = E
    x[1, 4] = I
    x[1, 5] = R
    x[1, 6] = N
    for u = 2:length(t)
        r = rand(Float64, 2::Int)

        x[u, 2] = x[u-1, 2] + (-(r[1] * 0.7 + β) * x[u-1, 2] * x[u-1, 4] / x[u-1, 6] + ζ * (γ) * x[u-1, 4]) * dt
        x[u, 4] = x[u-1, 4] + ((r[1] * 0.7 + β) * x[u-1, 2] * x[u-1, 4] / x[u-1, 6] - (r[2] * 0.15 + γ) * x[u-1, 4]) * dt
        x[u, 5] = x[u-1, 5] + ((1 - ζ) * (r[2] * 0.15 + γ) * x[u-1, 4]) * dt
        x[u, 6] = x[u-1, 6]

        #= if x[u,4] > .4*x[u,6]
            x[u,2] = x[u,2] - η*x[u,2]
            x[u,1] = x[u,1] + η*x[u,2]
        end =#
        #= if x[u,5] > .7999999*x[u,6] && x[u,5] < .8000001*x[u,6]
            k = round(Int64,u/10)
            println("La pandemia acabó en el día $k")
        end =#
    end
    fig = Figure(resolution = (700, 500))
    axis = Axis(fig[1, 1], ylabel = "personas",
    xlabel = "tiempo", title = "SIRS")
    lines!(axis, t, x[:, 2], color = :blue, label = "susceptible")
    lines!(t, x[:, 4], color = :red, label = "infected")
    lines!(t, x[:, 5], color = :green, label = "removed")
    axislegend()
    display(fig)
    save("sirs.png", fig)
end
;