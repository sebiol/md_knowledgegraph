require_relative './kbase_index'
require_relative './kbase_node'

class KBaseFileParser
    
    def parseDir(path)
        index = KBaseIndex.new()
        # switch directory so paths provided by glob are relative from base dir
        Dir.chdir(path)
        Dir.glob('**/*.md') do |file|
            node = parseFile(path, file)
            index.addNode(node)
        end
        # recursive go through dirs
        return index
    end

    def parseFile(basePath, relativeFilePath)
        node_path = relativeFilePath
        node_title = nil
        node_summary = nil
        node_tags = nil
        filePath = File.join(basePath, relativeFilePath)

        valid_metadata = false
        File.open(filePath, "r") do |file|
            file.each_line do |line|
                #puts line

                captures = line.scan(/^(.+): (.+)$/)

                next unless captures[0]

                case captures[0][0]
                when 'title'
                    node_title = captures[0][1].strip
                when 'summary'
                    node_summary = captures[0][1].strip
                when 'tags'
                    node_tags = captures[0][1].strip.split(",")
                end

                if node_title and node_summary and node_tags
                    valid_metadata = true
                    break
                end
            end
        end

        if valid_metadata
            return KBaseNode.new(node_title, node_summary, node_tags, node_path)
        end
        return nil
    end

end