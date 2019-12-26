require_relative './kbase_node'
require_relative './kbase_tag'

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
        node.tags.each do |tag_text| 
            # Check for Subtag ::
            tag_name, sub_tag_name = tag_text.split("::")
            tag = @nodes_by_tag[tag_name]
            
            if !tag
                tag = KBaseTag.new(tag_name)
                @nodes_by_tag[tag_name] = tag
            end

            tag.addNode(node, sub_tag_name)
        end
    end

    def getNodeByTitle(title)
        @nodes_by_title[title]
    end

    def getNodesByTag(tag)
        @nodes_by_tag[tag]
    end
end