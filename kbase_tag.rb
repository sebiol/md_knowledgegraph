class KBaseTag
    attr_reader :name, :nodes, :subtags

    def initialize(name)
        @name = name
        @nodes = []
        @subtags = {}
    end

    def addNode(node, subtagName)
        if subtagName 
            subTag = @subtags[subtagName]
            
            if !subTag
                subTag = KBaseTag.new(subtagName)
                @subtags[subtagName] = subTag
            end

            subTag.addNode(node, nil)            
         else 
            @nodes << node
        end
    end

end