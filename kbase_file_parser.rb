require_relative './kbase_index'
require_relative './kbase_node'

class KBaseFileParser
    
    def parseDir(path)
    end

    def parseFile(filePath)
        node_path = filePath
        node_title = nil
        node_summary = nil
        node_tags = nil
        File.open(filePath, "r") do |file|
            file.each_line do |line|
                puts line

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
                    break
                end
            end
        end
        KBaseNode.new(node_title, node_summary, node_tags, node_path)
    end

end