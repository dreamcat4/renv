#!/usr/bin/env ruby

def sudo_chown file
  if ENV['SUDO_USER']
    group = ENV['SUDO_USER']
    require 'etc'
    group = Etc.getgrgid(ENV['SUDO_GID'].to_i).name if ENV['SUDO_GID']
    require 'fileutils'
    FileUtils.chown(ENV['SUDO_USER'], group, file)
  end
  file
end

def new_sourcefile
  require 'tempfile'
  tempfile = Tempfile.new("renv_sourcefile.")
  file = "#{tempfile.path}-"
  FileUtils.cp(tempfile.path,file)
  sudo_chown file
end

def write_sourcefile_and_exit
  file = SOURCEFILE[0]
  File.open(file,'w') do |o|
    o << "#!/usr/bin/env bash" << "\n"
    changed_keys.each_pair do |k,v|
      o << export(k,v) << "\n"
    end
    o << "rm -f \"#{file}\""
  end
  sudo_chown file
  exit 0
end

SOURCEFILE = []
RENV = {}

if ARGV[0] == "--get-passvars"
  sudo_pass_vars = "PATH BUNDLE_PATH GEM_HOME GEM_PATH"
  puts sudo_pass_vars
  exit 0
end

if ARGV[0] == "--get-sourcefile"
  puts new_sourcefile
  exit 0
end

if ARGV[0] == "--set-sourcefile" && ARGV[1]
  SOURCEFILE << ARGV[1]
  ARGV.shift; ARGV.shift
end


# bash writer methods
def changed_keys
  ck = {}
  RENV.each_pair do |k,v|
    ck[k] = RENV[v] unless ENV[k] == RENV[k]
  end
  ck
end

def source file
  # eg for sourcing the /etc/renvrc file
  "source \"#{file}\""
end

def source_line filename
  "if [ -s \"#{filename}\" ] ; then source \"#{filename}\" ; fi"
end

def export k, v
  "export #{k}=\"#{v}\""
end





# application methods
  # parse args (ARGV)
  # initialize cli object
  # branch out to processing methods
  # perform actions






# exit portal
write_sourcefile_and_exit unless SOURCEFILE.empty?

