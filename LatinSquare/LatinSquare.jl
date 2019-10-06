function position(index, n)
    index -= 1
    (index ÷ n + 1, index % n + 1)
end

function Candidates(index, n, rows, colums)
    i, j = position(index, n)
    setdiff(setdiff(1:n, rows[i]), colums[j])
end

function can_be_set(x, index, n, rows, colums)
    i, j = position(index, n)
    if x ∈ rows[i] || x ∈ colums[j]
        return false
    end
    true
end

function LatinSquare!(index, n, M::Matrix, rows, colums)
    if index > n * n
        global counter += 1
        # println(M)
    else
        for x ∈ Candidates(index, n, rows, colums)
            if can_be_set(x, index, n, rows, colums)
                i, j = position(index, n)
                M[i, j] = x
                push!(rows[i], x)
                push!(colums[j], x)
                LatinSquare!(index + 1, n, M, rows, colums)
                pop!(rows[i], x)
                pop!(colums[j], x)
            end
        end
    end
end


function CountingLatinSquare(n::Int)
    M = zeros(Int, n, n)
    rows = [Set{Int}() for i ∈ 1:n]
    colums = [Set{Int}() for i ∈ 1:n]
    LatinSquare!(1, n, M, rows, colums)
end


for i ∈ 1:5
    @info "When the order of the Latin square is " * string(i)
    global counter = BigInt(0)
    @time CountingLatinSquare(i)
    println("The number is ", counter)
end

# when LatinSquare is 1*1 ,the number of combination is 1
# when LatinSquare is 2*2 ,the number of combination is 2
# when LatinSquare is 3*3 ,the number of combination is 12
# when LatinSquare is 4*4 ,the number of combination is 576
# when LatinSquare is 5*5 ,the number of combination is 161280
