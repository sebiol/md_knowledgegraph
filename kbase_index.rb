require_relative './kbase_node'

class KBaseIndex
    def initialize()
        @nodes_by_title = Hash.new
    end

    def addNode(node)
        @nodes_by_title[node.title] = node
    end

    def getNodeByTitle(title)
        @nodes_by_title[title]
    end
end