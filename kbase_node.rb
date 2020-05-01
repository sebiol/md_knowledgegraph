require 'json'

class KBaseNode
    attr_reader :title, :summary, :tags, :path, :relPath, :filename

    def initialize(title, summary, tags, path)
        @title = title ? title : File.basename(path, ".*")
        @path = path
        @summary = summary ? summary : "NA"
        @tags = stripLinkFormatFromTags(tags)
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

   def to_json(*args)
      {
         JSON.create_id => self.class.name,
         'title' => @title,
         'summary' => @summary,
         'path' => @path,
         'tags' => @tags.to_json
      }.to_json(*args)
   end

   def self.json_create(h)
      new(h['title'],h['summary'],h['tags'],h['path'])
   end

     private

     # Strips the link formatting from tags
     # Example
     #  [@AwesomeTag] -> AwesomeTag
     #  [@AwesomeTag::SubTag] -> AwesomeTag::SubTag
     #  @InbetweenTag -> InbetweenTag
     #  oldTag -> oldTag
     def stripLinkFormatFromTags(tags)
      return [] if !tags
      return [] if !tags.respond_to?('map')

      tmpTags = tags.map do |tag|
         if !tag["@"]
            # if the tag does not contain an "@" it is in the old format and should be used as is
            tag
         else
            # if the tag contains an "@" it must be in new format meaning [@tagName](tagPath)
            # so the tagname must be extracted
            tag[/@([^\]]*)/,1]
         end
      end
      
      # remove empty tags
      tmpTags.reject(&:empty?)
   end
end