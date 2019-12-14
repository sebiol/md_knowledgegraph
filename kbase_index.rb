require_relative './kbase_node'

class KBaseIndex
    attr_reader :nodes_by_tag, :nodes_by_title

    def initialize()
        @nodes_by_title = Hash.new
        @nodes_by_tag = Hash.new
    end

    # add node to the indexes
    def addNode(node)
        return if !node

        # Add node to the index by its title
        @nodes_by_title[node.title] = node
        
        # Add node the index corresponding to each of the ndoes tags
        node.tags.each do |tag| 
            tag_array = @nodes_by_tag[tag]
            
            if !tag_array
                tag_array = []
                @nodes_by_tag[tag] = tag_array
            end

            tag_array << node
        end
    end

    def getNodeByTitle(title)
        @nodes_by_title[title]
    end

    def getNodesByTag(tag)
        @nodes_by_tag[tag]
    end
end