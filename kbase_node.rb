class KBaseNode
    attr_reader :title, :summary, :tags, :path, :relPath, :filename

    def initialize(title, summary, tags, path)
        @title = title ? title : File.basename(path, ".*")
        @path = path
        @summary = summary ? summary : "NA"
        @tags = tags ? tags : []
     end

     def ==(other)
        self.class === other and
        other.title == @title
     end

     alias eql? ==

     def hash
        @title.hash
     end

     def relPath
      File.dirname(@path)
     end

     def filename
      File.basename(@path)
     end
end