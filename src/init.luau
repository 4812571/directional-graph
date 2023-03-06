type Node = any
type Edge = any

local DiGraph = {}
DiGraph.__index = DiGraph

function DiGraph.new()
    local self = setmetatable({}, DiGraph)
    self._edges = {}
    return self
end

function DiGraph:AddEdge(node1: Node, node2: Node, edge: Edge?)
    -- If the node is not in the graph, add it
    if not self._edges[node1] then
        self._edges[node1] = {}
    end

    -- If the edge is not specified, 'true' is used as a default
    self._edges[node1][node2] = if edge ~= nil then edge else true
end

function DiGraph:AddEdgePair(node1: Node, node2: Node, edge: Edge?)
    self:AddEdge(node1, node2, edge)
    self:AddEdge(node2, node1, edge)
end

function DiGraph:RemoveEdge(node1: Node, node2: Node)
    -- If the node is not in the graph, it has no edges, so return early
    if not self._edges[node1] then
        return
    end

    -- Remove the edge from the graph
    self._edges[node1][node2] = nil

    -- If the node has no remaining edges, remove it from the graph
    if not next(self._edges[node1]) then
        self._edges[node1] = nil
    end
end

function DiGraph:RemoveEdgePair(node1: Node, node2: Node)
    self:RemoveEdge(node1, node2)
    self:RemoveEdge(node1, node2)
end

function DiGraph:GetNodes(): {[Node]: {Edge}}
    return self._edges
end

function DiGraph:GetEdges(node: Node): {Edge}
    if not self._edges[node] then
        return {}
    end

    return self._edges[node]
end

function DiGraph:GetEdge(node1: Node, node2: Node): Edge?
    if not self._edges[node1] then
        return nil
    end

    return self._edges[node1][node2]
end

function DiGraph:HasEdge(node1: Node, node2: Node): boolean
    if not self._edges[node1] then
        return false
    end

    return self._edges[node1][node2] ~= nil
end

return DiGraph