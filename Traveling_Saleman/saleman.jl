function saleman(n)
    function get_points_and_distances(n::Integer)
        distances = zeros(n, n)
        points = [rand(1:n, 2) for _ ∈ 1:n]
        for i = 1:n
            for j = 1:i-1
                dis = points[i] - points[j]
                distances[j, i] = distances[i, j] = sqrt(dis' * dis) 
            end
        end
        distances, points
    end

    s = Set(1:n)
    l = Vector()
    m = typemax(Int128)
    dis, ps = get_points_and_distances(n)

    function total_distance(l)
        n = length(l)
        push!(l, l[1])
        x = sum(dis[l[i], l[i+1]] for i = 1:n)
        pop!(l)
        m = m < x ? m : x
    end

    function each_path()
        if isempty(s)
            total = total_distance(l)
        else
            for each in s
                push!(l, each)
                delete!(s, each)
                each_path()
                push!(s, each)
                pop!(l)
            end
        end
    end
    each_path()
    @info "When n is $n , minimum distances is $m"
    m
end

for i = 1:13
    @time saleman(i)
end
