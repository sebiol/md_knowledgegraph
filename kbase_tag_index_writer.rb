require_relative './kbase_node'

class KBaseTagIndexWriter

    def initialize(basePath)
        @basePath = basePath
    end

    def writeTagIndex(tag)
        return if !tag

        File.open(File.join(@basePath, tag.name + ".md"), "w") do |file|
            writeTagToFile(file, tag, 1)
        end
    end

    private 

    ## Write tags to an opened file recursively
    def writeTagToFile(file, tag, hierarchy_level)
        return if !file
        return if !tag

        ## Write Heading
        file.puts("#{"#" * hierarchy_level} #{tag.name}")

        ## Write nodes
        tag.nodes.each do |node|
            line = "* [#{node.title}](#{File.join(".", node.path)}) #{node.summary}"
            file.puts(line)
        end

        ## Write subtags recursively
        hierarchy_level = hierarchy_level + 1
        tag.subtags.each_value do |subtag|
            writeTagToFile(file, subtag, hierarchy_level)
        end
    end

end