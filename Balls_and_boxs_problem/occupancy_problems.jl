function c(n::T, k::T) where T<:Integer
    k < 0 && return zero(T)
    k > n && return zero(T)
    (k == 0 || k == n) && return one(T)
    k == 1 && return one(T)*n
    if k > (n>>1)
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

C(n,r)=c(BigInt(n),BigInt(r))
P(n)=factorial(BigInt(n))

Cᴿ(n,r)=C(n+r-1,r)
Pᴿ(n,r)=BigInt(n)^r


function S₂(n::T,r::T) where T<:Integer
    s=zero(BigInt)
    for i ∈ 0:n
        if isodd(i)
            s-=C(r,i)*Pᴿ(r-i,n)
        else
            s+=C(r,i)*Pᴿ(r-i,n)
        end
    end
    s÷P(r)
end
