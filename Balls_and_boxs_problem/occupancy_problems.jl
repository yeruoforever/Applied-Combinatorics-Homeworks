function c(n::T, k::T) where {T<:Integer}
    k < 0 && return zero(T)
    k > n && return zero(T)
    (k == 0 || k == n) && return one(T)
    k == 1 && return one(T) * n
    if k > (n >> 1)
        k = (n - k)
    end
    x::T = nn = n - k + 1
    nn += 1
    rr = 2
    while rr <= k
        x = div(widemul(x, nn), rr)
        rr += 1
        nn += 1
    end
    convert(T, x)
end

"""
r-combination of an n-set (sampling without replacement).
"""
C(n, r) = c(BigInt(n), BigInt(r))

"""
r-permutation of the n-set (sampling without replacement).
"""
P(n) = factorial(BigInt(n))

"""
r-combination of an n-set (sampling with replacement).
"""
Cᴿ(n, r) = C(n + r - 1, r)


"""
r-permutation of an n-set (sampling with replacement).
"""
Pᴿ(n, r) = BigInt(n)^r



"""
Stirling number of the secend kind.
"""
function S₂(n::T, r::T) where {T<:Integer}
    s = zero(BigInt)
    for i ∈ 0:n
        if isodd(i)
            s -= C(r, i) * Pᴿ(r - i, n)
        else
            s += C(r, i) * Pᴿ(r - i, n)
        end
    end
    s ÷ P(r)
end


function situation₁(n, k, box_can_be_empty::Bool)
    box_can_be_empty ? Pᴿ(k, n) : P(k) * S₂(n, k)
end

function situation₂(n, k, box_can_be_empty::Bool)
    box_can_be_empty ? C(k + n - 1, n) : C(n - 1, k - 1)
end

function situation₃(n, k, box_can_be_empty::Bool)
    box_can_be_empty ? sum(S₂(n, i) for i ∈ 1:k) : S₂(n, k)
end
"""
                                                     occupancy problem

        distinguishable_balls  |  distinguishable_boxs  |  box_can_be_empty  |  the_number_of_methods(n balls,k boxs)
    ------------------------------------------------------------------------------------------------------------------
    situation₁:
    1a          yes            |          yes           |         yes        |                   kⁿ
    1b          yes            |          yes           |          no        |                k!S(n,k)
    ------------------------------------------------------------------------------------------------------------------
    situation₂:
    2a           no            |          yes           |         yes        |               C(k+n-1,n)
    2b           no            |          yes           |          no        |               C(n-1,k-1)
    ------------------------------------------------------------------------------------------------------------------
    situation₃:
    2a          yes            |           no           |         yes        |               C(n-1,k-1)
    3b          yes            |           no           |          no        |               C(n-1,k-1)
    ------------------------------------------------------------------------------------------------------------------
"""
function occupancy_problem(
    n::T,
    k::T,
    distinguishable::Tuple{Bool,Bool},
    box_can_be_empty::Bool,
) where {T<:Integer}
    distinguishable_balls, distinguishable_boxs = distinguishable
    if distinguishable_boxs && distinguishable_balls
        return situation₁(n, k, box_can_be_empty)
    elseif distinguishable_boxs && !distinguishable_balls
        return situation₂(n, k, box_can_be_empty)
    elseif !distinguishable_boxs && distinguishable_balls
        return situation₃(n, k, box_can_be_empty)
    else
        return "situation 4 is not implemented."
    end
end
