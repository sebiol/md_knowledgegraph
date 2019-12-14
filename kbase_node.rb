class KBaseNode
    attr_reader :title, :summary, :tags, :path

    def initialize(title, summary, tags, path)
        @title = title
        @summary = summary
        @tags = tags
        @path = path
     end

     def ==(other)
        self.class === other and
        other.title == @title
     end

     alias eql? ==

     def hash
        @title.hash
     end
end