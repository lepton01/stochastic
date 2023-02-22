# Angel Ortiz

#import Pkg; #(1)
#Pkg.add("Plots"); #(1)
#Pkg.add("BenchmarkTools"); #(2)

using Plots #(1)
#using BenchmarkTools #(2)
using Statistics
plotlyjs() #(1*)

t = 100000
x = zeros(Float64,t::Int64,1::Int64)

for i = 1:t
    tp = 1*rand(Float64,1)
    ta = 1*rand(Float64,1)
    if ta[1] - tp[1] < 0
        x[i] = 1 - tp[1]
    end
    if ta[1] - tp[1] >= 0
        x[i] = ta[1] - tp[1]
    end
end
mean(x);