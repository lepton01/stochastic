#Angel Ortiz, A00828463@tec.mx
#14-03-2022

#import Pkg
#Pkg.add("CairoMakie")

using CairoMakie, Statistics, LinearAlgebra

f(x, y) = 2x*y;

lims = 2π

x = -lims:0.001:lims
y = -lims:0.001:lims

maxit = 1000
mincost = -10000

psize = 20
mrate = 0.1
sel = 0.5

cp = 2

keep = floor(sel*psize)
nmut = ceil((psize-1)*mrate*cp)
mating = ceil((psize-keep)/2)

ngen = 0
popcr = 2*lims*rand(psize, cp)

costf = zeros((1, psize))

for i = 1:psize
    costf[i] = f(popcr[i, 1],popcr[i, 2])
end

[costf, indxc] = sort(costf)

popcr = popcr[indxc, :]

minc = min(costf)
meanc = mean(costf)

# Iteraciones

while ngen<maxit
    ngen += 1

    M = ceil((psize-keep)/2)
    prob = 

    odds = [0 cumsum(prob[1:keep]')

    pick1 = rand(1, M)
    pick2 = rand(1, M)
end