#!/usr/bin/env ruby
require 'fileutils'
require 'pathname'
require 'yaml'

def loadMapping(file)
  begin
    mapping = YAML::load_file(file)
  rescue
    mapping = nil
  end
  return mapping
end

def saveMapping(mapping, file)
  File.open(file, 'w') do |f|
    f.write mapping.to_yaml
  end
end

def findExactMapping(mapping,path)
  mapping.each_with_index do |entry,index|
    if entry[0] == path
      return { :srcDir => entry[0], :buildDir => entry[1], :index => index, :type => :SRC_DIR }
    elsif  entry[1] == path
      return { :srcDir => entry[0], :buildDir => entry[1], :index => index, :type => :BUILD_DIR }
    end
  end
  return nil
end

def findMapping(mapping,path)
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


def createBuildDir(baseDir,baseName)
   basePath = Pathname.new("#{baseDir}/#{baseName}")
   return basePath.to_s unless File.exists?(basePath)
   i = 1
   while File.exists?(basePath.to_s + i.to_s) do i += 1 end
   return basePath.to_s + i.to_s
end

if __FILE__ == $0
  require 'rubygems'
  require 'trollop'

  # redirect stdout to stderr
  $stdout = $stderr
  
  p = Trollop::Parser.new do
    banner <<-EOS
Usage:
      builddir [options] [baseName]
where [options] are:
EOS
    opt :build,         "Switch to the build directory"
    opt :buildBaseDir,  "Base directory for the build directories", :default => "/static_tmp/mario/build"
    opt :create,        "Create build directory if necessary"
    opt :help,          "Display this help message"
    opt :source,        "Switch to the source directory"
    opt :verbose,       "Verbose mode for debugging"
  end
  opts = {}
  Trollop::with_standard_exception_handling p do
    opts = p.parse ARGV
    raise Trollop::HelpNeeded if ARGV.size() > 1 # show help screen
  end
  currentDir = Dir.pwd
  
  # clean the paths
  opts[:buildBaseDir]    = File.expand_path(opts[:buildBaseDir])    if opts[:buildBaseDir]
  mappingsFile = "#{opts[:buildBaseDir]}/builddir_mapping.yml"
  baseName = File.basename(currentDir)
  baseName = File.basename(ARGV[0]) unless ARGV.empty?
  
  if opts[:verbose]
    puts "Current Directory   : #{currentDir}"
    puts "Build Base Directory: #{opts[:buildBaseDir]}"
    puts "Mappings File       : #{mappingsFile}"
    puts "Basename            : #{baseName}"
    puts ""
  end
  
  if opts[:build] && opts[:source]
    puts "ERROR! Can not switch to source and build simultaneously."
    exit -1
  end
  
  mapping = loadMapping(mappingsFile)
  puts "WARNING! Mappings could not be loaded." if mapping == nil && opts[:verbose]
  mapping ||= []
  
  entry = findMapping(mapping, currentDir)
  if entry == nil && !opts[:create]
    puts "ERROR! No SrcDir <-> BuildDir mapping could be found."
    exit -1
  elsif entry == nil
    buildDir = createBuildDir(opts[:buildBaseDir],baseName)
    mapping << [ currentDir, buildDir ]
    puts "New Mapping: #{currentDir} <-> #{buildDir}" if opts[:verbose]
    entry = { :srcDir => currentDir, :buildDir => buildDir, :index => mapping.size-1, :type => :SRC_DIR }
  elsif opts[:verbose]
    puts "Mapping Found: #{entry[:srcDir]} <-> #{entry[:buildDir]}"
  end
  
  # create the directory when needed
  unless File.exists?(entry[:buildDir])
    puts "Creating build directory" if opts[:verbose]
    FileUtils.mkdir_p(entry[:buildDir])
  end
  
  saveMapping(mapping,mappingsFile)
  
  dstDir = entry[:srcDir]
  if opts[:build] || (!opts[:build] && !opts[:source] && entry[:type] == :SRC_DIR)
    dstDir = entry[:buildDir]
  end
  puts "Change directory to: #{dstDir}" if opts[:verbose]
  STDOUT.puts dstDir
end
