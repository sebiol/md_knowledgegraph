require_relative './kbase_node'

class KBaseTagIndexWriter

    def initialize(basePath)
        @basePath = basePath
    end

    def writeTagIndex(tag, nodes)
        File.open(File.join(@basePath, tag + ".md"), "w") do |file|
            file.puts("# Index for #{tag}")
            nodes.each do |node|
                line = "* [#{node.title}](#{File.join(".", node.path)}) #{node.summary}"
                file.puts(line)
            end
        end
    end

end