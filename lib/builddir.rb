require "builddir/version"
require "builddir/utils"

require 'fileutils'
require 'pathname'
require 'yaml'

module Builddir

	# Loads the BuildDir <-> SourceDir mapping from the file
	#
	# @param file [String] path of the mapping file
	# @return [nil, Array<Array(String, String)>] The loaded mapping. nil on error
	def Builddir.loadMapping(file = nil)
		file = getMappingsFilePath() if file.nil?
		begin
			mapping = YAML::load_file(file)
		rescue
			mapping = nil
		end
		return mapping
	end

	# Saves the BuildDir <-> SourceDir mapping to a file
	#
	# @param mapping [Array<Array(String, String)>] the mapping which should be saved
	# @param file [String] path of the mapping file
	def Builddir.saveMapping(mapping, file = nil)
		file = getMappingsFilePath() if file.nil?
		
		# create the directory when needed
		dirname = File.dirname(file)
		FileUtils.mkdir_p(dirname) unless File.exists?(dirname)
		
		File.open(file, 'w') do |f|
			f.write mapping.to_yaml
		end
	end

	# Searches through the mapping for a direct path match
	#
	# @param mapping [Array<Array(String, String)>] the mapping which should checked
	# @param path [String] path of the searched directory
	# @return [nil, { Symbol => String,Symbol}] the found mapping. nil on error
	def Builddir.findExactMapping(mapping,path)
		mapping.each_with_index do |entry,index|
			if entry[0] == path
				return { :srcDir => entry[0], :buildDir => entry[1], :index => index, :type => :SRC_DIR }
			elsif  entry[1] == path
				return { :srcDir => entry[0], :buildDir => entry[1], :index => index, :type => :BUILD_DIR }
			end
		end
		return nil
	end

	# Searches through the mapping for a path match.
	# Parent directories are considered for the matching as well.
	#
	# @param mapping [Array<Array(String, String)>] the mapping which should checked
	# @param path [String] path of the searched directory
	# @return [nil, { Symbol => String,Symbol}] the found mapping. nil on error
	def Builddir.findMapping(mapping,path)
		lastpn = nil
		pn  = Pathname.new(path)
		while pn != lastpn do
			entry = findExactMapping(mapping,pn.to_s)
			return entry if entry
			lastpn = pn
			pn = pn.parent()
		end
		return nil
	end
	
	def Builddir.getBuildBasePath()
		return ENV['DEFAULT_BUILDDIR'] || "/tmp/builddir"
	end
	
	def Builddir.getMappingsFilePath()
		return File.join(getBuildBasePath(),"builddir_mapping.yml")
	end
end
