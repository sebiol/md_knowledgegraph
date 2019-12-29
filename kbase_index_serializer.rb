require_relative './kbase_index'
require 'json'

class KBaseIndexSerializer

    def initialize(basePath)
        @basePath = basePath
    end
    
    def serializeIndexToJSon(index)
        File.open(File.join(@basePath, "index.json"),"w") do |f|
            f.write(index.nodes_by_title.to_json)
        end
    end

end