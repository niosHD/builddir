require_relative 'version'

module Builddir

	# Return the directory with the project libraries
	# http://stackoverflow.com/a/5805783
	#
	# @return [String] path to the library directory
	def Builddir.getGemLibdir
		t = ["#{File.dirname(File.expand_path($0))}/../lib/#{NAME}",
					"#{Gem.dir}/gems/#{NAME}-#{VERSION}/lib/#{NAME}"]
		t.each {|i| return i if File.readable?(i) }
		raise "both paths are invalid: #{t}"
	end

end 
