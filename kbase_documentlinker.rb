require_relative './kbase_node'
require_relative './kbase_index'

class KBaseDocumentLinker

    def initialize(basePath, index)
        @basePath = basePath
        @index = index
    end
    
    def linkAllDocumentsInPath()
        Dir.each_child(@basePath) do |f|
            if File.directory?(f)
                Dir.glob(f + '/**/*.md') do |file|                    
                    updateLinksInDocument(file)
                end
            end
        end
    end

    def updateLinksInDocument(filePath)
        File.open(filePath, "r") do |file|
            File.open(filePath + ".tmp", "w") do |outFile|
                file.each_line do |line|
                    updatedLine = updateLine(line)
                    #puts updatedLine
                    outFile.puts(updatedLine)
                end
            end
        end
        File.rename filePath + ".tmp", filePath
    end

    private

    def updateLine(line)
        #scanForLinks = /\[([^\]]+)\]\(([^\)]+)\)/ can return multiple matches
        #scanForIncludes = /^(.+)\[>([^\]]+)\]\(([^\)]+)\)(.*)$/ should return a singe match

        # Check for includes
       preambel, title, path, summary = line.scan(/^(.+)\[>([^\]]+)\]\(([^\)]+)\)(.*)$/)[0]
        if title
            #puts "#{preambel} ; #{title} ; #{path} ; #{summary}"
            #puts title.strip
            node = @index.getNodeByTitle(title.strip)
            if node
                #pp node
                return "#{preambel}[> #{node.title}](#{node.path}) #{node.summary}"
            end
        end 

        #puts line.scan(/\[([^>\]][^\]]+)\]\(([^\)]+)\)/)
        # check link
        
        return line
    end

end