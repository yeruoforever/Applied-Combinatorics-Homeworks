function swap!(A::SubArray, i::Int, j::Int)
    A[i], A[j] = A[j], A[i]
end

function is_reverse_lexicographic_order(A::Array, cmp = isless)
    for i = 1:length(A)-1
        if isless(A[i], A[i+1])
            return false
        end
    end
    return true
end

function find_iₘₐₓ_where_πᵢ_isless_πᵢ₊₁(A::Array, cmp = isless)
    m = 1
    for i = 1:length(A)-1
        if cmp(A[i], A[i+1])
            m = i
        end
    end
    return m
end

function find_πₘᵢₙ_where_πᵢ_isless_πₘᵢₙ(A::SubArray, cmp = isless)
    m = 2
    for i = 2:length(A)
        if cmp(A[1], A[i]) && cmp(A[i], A[m])
            m = i
        end
    end
    return m
end

function next_permutataion!(A::Array, cmp = isless)
    if is_reverse_lexicographic_order(A, cmp)
        return false
    end
    i = find_iₘₐₓ_where_πᵢ_isless_πᵢ₊₁(A, cmp)
    B = @view A[i:end]
    j = find_πₘᵢₙ_where_πᵢ_isless_πₘᵢₙ(B, cmp)
    swap!(B, 1, j)
    B = @view A[i+1:end]
    sort!(B)
    return true
end

function add_head_zero!(l)
    pushfirst!(l, false)
end

function add_head_one!(l)
    reverse!(l)
    pushfirst!(l, true)
end

function Gray(n::Integer, r::Integer)
    if r == 0
        return [[false for _ = 1:n]]
    elseif r == n
        return [[true for _ = 1:n]]
    else
        ones = map(add_head_one!, Gray(n - 1, r - 1))
        zeros = map(add_head_zero!, Gray(n - 1, r))
        return append!(ones, zeros)
    end
end

function subset(S,r)
    n=length(S)
    s=sort(S)
    if r==0
        return []
    elseif n==r
        return s
    else
        bitmaps=Gray(n,r)
        return map(x->s[x],bitmaps)
    end
end


function main()
    A = [1, 2, 3, 4,5,6,7,8]
    println(A)
    i = 1
    while next_permutataion!(A)
        i += 1
        # println(A)
    end
    @show factorial(8) == i

    S=[1,2,3,4,5,6,7,8]
    ss=subset(S,3)
    for each in ss
        println(each)
    end
end



main()
