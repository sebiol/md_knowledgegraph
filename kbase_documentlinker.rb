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

    private

    def updateLinksInDocument(filePath)
        File.open(filePath, "r") do |file|
            File.open(filePath + ".tmp", "w") do |outFile|
                file.each_line do |line|
                    updatedLine = updateLine(line)
                    outFile.puts(updatedLine)
                end
            end
        end
        File.rename filePath + ".tmp", filePath
    end

    def updateLine(line)
        # Check for includes
        scanForIncludes = /^(.+)\[>([^\]]+)\]\(([^\)]+)\)(.*)$/
        preambel, title, path, summary = line.scan(scanForIncludes)[0]
        if title
            node = @index.getNodeByTitle(title.strip)
            # TODO also use gsub to preserve line endings
            if node
                return "#{preambel}[> #{node.title}](#{node.path}) #{node.summary}\r"
            end
        end 

        # Update paths for any links found were the link name matches a title from a node
        # Todo: guard with check for a local link 
        # Todo: guard against multiple ndoes with same title
        # Todo: Handle updated titles, when path matches a file?
        scanForLinksToUpdate = /\[([^\]]+)\]\(([^\)]+)\)/
        line.gsub!(scanForLinksToUpdate) do |match|
            node = @index.getNodeByTitle($1.strip)
            if node
                "[#{node.title}](#{node.path})"
            else
                match
            end
        end
        
        # Add new LInks by Title
        # New links can be specified as "[[New Link]]" without the path
        scanForNewLinks = /\[\[([^\]]+)\]\]/
        line.gsub!(scanForNewLinks) do |match|
            node = @index.getNodeByTitle($1.strip)
            if node
                "[#{node.title}](#{node.path})"
            else
                match
            end
        end

        return line
    end

end