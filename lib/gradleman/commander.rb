require 'optparse'

module Gradleman
  class Commander
    class << self
      def order(args)
        options = {}
        commands = {
          'inspect-multi-dex' => OptionParser.new do |opts|
            opts.banner = set_banner('inspect-multi-dex')
            
            opts.on('-d', '--directory DIRECTORY', 'Specify the directory for your codebase') do |directory|
              options[:directory] = directory
            end
            
            opts.on('-p', '--project PROJECT', 'Specify the gradle project name') do |project|
              options[:project] = project
            end
          end
        }
        valid_cmds = ['inspect-multi-dex']
        if valid_cmds.include?(args[0])
          begin
            commands[args.shift].order!
          rescue OptionParser::InvalidOption => e
            puts e.message
          end
          options
        else
          puts "Unknown commands [#{args[0]}], only support #{valid_cmds.inspect}."
        end
      end
      
      def get_caller_file_name
        caller[-1].match(/\S+\.rb/)
      end
      
      def set_banner(cmd)
        "Usage: #{get_caller_file_name} #{cmd} [options]"
      end
    end
    
    private_class_method :new, :get_caller_file_name, :set_banner
  end
end