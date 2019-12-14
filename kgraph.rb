require 'optionparser'
options = {:link => :all, :store_index => true, :generate_index_files => true}
path = "./"

OptionParser.new do |opts|
  opts.banner = "Usage: kgraph [options] [path]\nDefaults: kgraph -l all -s ." + File::SEPARATOR
  opts.on("-c", "--configfile [FILE]", String, "Config File to use") do |configfile|
    options[:configfile] = configfile
  end
  opts.on("--[no-]index-files", "Generate index file for each tag") do |i|
    options[:generate_index_files] = i
  end
  opts.on("-l [Type]", "--[no-]link [Type]", [:files, :tags, :includes, :all], "Generate links between files for link type (files, tags, includes, all)") do |linktype|
    options[:link] = linktype
  end
  opts.on("--[no-]store-index", "Store index as json file") do |s|
    options[:store_index] = s
  end
end.parse!

pp options
pp ARGV

if ARGV[0]
  path = ARGV[0]
end

pp path