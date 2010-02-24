
# !! ARGGH! - NOT IMPLEMENTED YET !!

def install
  # write the source line to the shell profile, rc files

  # == install proceedure ==
  # read the /etc/renvrc and/or cli arguments
  renv_root = "/opt/renv"
  # install system ruby (if not exist)
  # gem install renv # (installs renv to the system gemdir)
  # $ renv install "/opt/renv"
  #  if renv_ruby symlink missing
  #    log user renv is not installed
  #    check for renv_path in /etc/renvrc
  #    or prompt user for installation dir
  #    copy the renv distribution files into renv_root
  #  initialize renv installation directory
  #   create a symlink to system_ruby
  #   create a symlink to renv_ruby
  #  write the hardcoded files for long_commands and sudo_pass_args
  #  write the source line to all the various rc files
  rc_files_append source_line("#{renv_root}/bin/renv")
  #  exec shell (replace the shell process with a new login shell)
  #  (renv-install only)
end


