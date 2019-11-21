using LinearAlgebra

# warshell algrathem

#假设图是有向图
function is_connected_graph(graph::BitMatrix,is_strongly_connected=false)
    # n个节点
    n_node=size(graph,1)
    g=copy(graph)
    c=g'
    # 在有N个节点的图中，从nᵢ到nⱼ的路径最多有n个中间点
    for i in 1:n_node
        g=g*c
        g=g.>0
    end
    #有向图中，任意的两个不同节点nᵢ、nⱼ，若nᵢ到nⱼ可达，或者nⱼ到nᵢ可达，那么这张图是连通的。
    if is_strongly_connected
        # 若判断强连通图(nᵢ到nⱼ可达、nⱼ到nᵢ也可达)
        g=g+g'
        g=g.>0
    end
    return all(g)
end
