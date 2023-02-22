#Angel Ortiz

using Statistics
f = x*sin(4*x) + 2*y*sin(2*y)
lims = 2*π::Float64
x = -lims:.1:lims
y = -lims:.1:lims
t = 5000::Int64
cmin = -10000::Int64
psize = 100::Int64
mrate = .05::Float64
sel = .5::Float64

cp = 2::Int64
kp = floor(sel*psize)
nm = ceil((psize - 1)*cp*mrate)
mate = ceil((psize - kp)/2)

g = 0::Int64
cr = 2*lims*rand(psize,cp) - lims
cost = zeros(Float64,psize,0)

for i = 1:psize
    cost[i] = f(cr[i,1],cr[i,2])
end

idx = sortperm(cost)
cost = cost[idx]

cr = cr[idx,:]

cmin[1] = min(cost)
cmean[1] = mean(cost)

while ng < t
    ng += 1

    M = ceil((psize - kp)/2)
    p = 
    
end