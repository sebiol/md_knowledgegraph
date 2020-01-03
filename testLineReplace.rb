require_relative './kbase_index'
require_relative './kbase_node'
require_relative './kbase_documentlinker'

index = KBaseIndex.new 
node1 = KBaseNode.new("FirstNode", "Summary of First Node", ["TagA, TagB"], "Path/To/FirstNode.md")
node2 = KBaseNode.new("SecondNode", "Summary of Second Node", ["TagB, TagC"], "Path/To/SecondNode.md")
node3 = KBaseNode.new("ThirdNode", "Summary of Third Node", ["TagC, TagD"], "Path/to/ThirdNode.md")

index.addNode(node1)
index.addNode(node2)
index.addNode(node3)

#pp @index
documentLinker = KBaseDocumentLinker.new("./", index) 

nullTest = "Just a regular text with only an [inserted] thought"
puts "Input: #{nullTest}"
puts "Expected: #{nullTest}"
testOutput =  documentLinker.send(:updateLine, nullTest)
puts "Actual: #{testOutput}"

testIncludePositive = " * [> FirstNode](Path/To/Replace) A Summary to be replaced."
puts "Input: #{testIncludePositive}"
puts "Expected: * [> FirstNode](Path/To/FirstNode.md) Summary of First Node"
testOutput = documentLinker.send(:updateLine, testIncludePositive)
puts "Actual: #{testOutput}"

testLinkPositive = "A test of Link [SecondNode](Path/To/Replace) update and new Links [[ThirdNode]]"
puts "Input: #{testLinkPositive}"
puts "Expected: A test of Link [SecondNode](Path/To/SecondNode.md) update and new Links [ThirdNode](Path/To/ThirddNode.md)"
testOutput = documentLinker.send(:updateLine, testLinkPositive)
puts "Actual: #{testOutput}"