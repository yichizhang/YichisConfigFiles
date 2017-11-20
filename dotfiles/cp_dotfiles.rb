#!/usr/bin/env ruby
require 'optparse'
require 'optparse/time'
require 'ostruct'
require 'pp'

require 'FileUtils'

def trimDir(dir)
  if dir[-1] != "/"
    dir += "/"
  end

  return dir
end

class MyOptParse

  def self.parse(args)
    options = OpenStruct.new
    options.verbose = false
    options.dry_run = false
    options.copy_dotfiles_back_from_user_dir = false

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: example.rb [options]"

      opts.separator ""
      opts.separator "Specific options:"

      opts.on("--back-from-user-dir", "Copy dotfiles back from user dir") do |opt|
        options.copy_dotfiles_back_from_user_dir = opt
      end

      # Boolean switch.
      opts.on("-d", "--[no-]dry-run", "Dry run") do |opt|
        options.dry_run = opt
      end

      # Boolean switch.
      opts.on("-v", "--[no-]verbose", "Run verbosely") do |opt|
        options.verbose = opt
      end

      opts.separator ""
      opts.separator "Common options:"
    end

    opt_parser.parse!(args)
    options
  end  # parse()

end  # class MyOptParse

class MyFileUtils
  def initialize( d = false )
    @dry_run = d
  end

  def cp_dotfiles(file, copy_dotfiles_back_from_user_dir)
    user_dir_file = ENV['HOME'] + "/" + file

    from_file = if copy_dotfiles_back_from_user_dir then user_dir_file else file end
    to_file = if copy_dotfiles_back_from_user_dir then file else user_dir_file end

    puts "Copying file:\n"
    puts "\tFROM `#{from_file}`\n"
    puts "\tTO   `#{to_file}`"

    if !@dry_run
      FileUtils.cp(from_file, to_file)
    end
  end
end  # class MyFileUtils

options = MyOptParse.parse(ARGV)
pp options
pp ARGV

fileUtils = MyFileUtils.new options.dry_run

Dir.glob(".*") do |file|
  next if File.directory?(file)

  fileUtils.cp_dotfiles(file, options.copy_dotfiles_back_from_user_dir)
end
