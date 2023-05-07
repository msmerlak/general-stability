using DrWatson, Glob, Revise
@quickactivate
foreach(includet, glob("*.jl", srcdir()))

using Plots, LaTeXStrings

p = Dict{Symbol,Any}(
    :scaled => false,
    :S => 100,
    :μ => 0.5,
    :μₛ => 0.0,
    :σ => 0.15,
    :α => 1.5,
    :β => 1.0,
    :γ => 1.0,
    :extinction_threshold => 1e-5,
    :dist => "gamma",
    :N => 1,
    :seed => rand(UInt)
);

evolve!(p; trajectory=true)

p[:trajectory].t

#= trajectories =#
plot(
    p[:trajectory],
    ylabel=L"x_i(t)",
    xlabel=L"t",
    yscale=:log,
    linewidth=1,
    legend=false,
    grid=false,
)

#= density distribution =#
p_eq = p[:trajectory].u[end]
histogram(p_eq,
    normalize=true,
    alpha=0.5,
    color=:green,
    ylabel=L"P(x_*)",
    xlabel=L"x_*",
    label=false,
    grid=false,
)

#= cavity solution with gaussian approximation =#
X = [x for x in 0.9*minimum(p_eq):0.0001:1.1*maximum(p_eq)]
plot!(X, [pdf(P_gauss(p), x) for x in X],
    labels=false, #"cavity - gaussian",
    linewidth=2,
    alpha=1,
    linecolor=:black,
    linestyle=:dash,
    grid=false
)

a, b, c = Cavity(p)

X=[x for x in .9*minimum(p_eq):.01:1.1*maximum(p_eq)]
plot!(X,[P_n(x, b, c, p) for x in X],
labels = false, #"cavity - gaussian",
linewidth = 2,
alpha = 1,
linecolor = :black,
grid = false,
size = (600,200)
)

p[:converged]

#= trajectories =#
plot(
    p[:trajectory],
    ylabel = L"x_i(t)",
    xlabel = L"t",
    yscale = :log,
    linewidth = 1,
    legend = false,
    grid = false,
)

#= density distribution =#
p_eq = p[:trajectory].u[end]
histogram(p_eq,
    normalize = true,
    alpha = .5,
    color = :green,
    ylabel = L"P(x_*)",
    xlabel = L"x_*",
    label = false,
    grid = false,
)

#= cavity solution with gaussian approximation =#
X=[x for x in .9*minimum(p_eq):.0001:1.1*maximum(p_eq)]
plot!(X,[pdf(P_gauss(p), x) for x in X],
labels = false, #"cavity - gaussian",
linewidth = 2,
alpha = 1,
linecolor = :black,
linestyle = :dash,
grid = false
)

a, b, c = Cavity(p)

X=[x for x in .9*minimum(p_eq):.01:1.1*maximum(p_eq)]
plot!(X,[P_n(x, b, c, p) for x in X],
labels = false, #"cavity - gaussian",
linewidth = 2,
alpha = 1,
linecolor = :black,
grid = false,
size = (600,200)
)