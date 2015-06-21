module Gradleman
  class ControlCenter
    class << self
      def launch
        command = ARGV[0]
        options = Commander.order(ARGV)
        case command
        when 'inspect-multi-dex'
          execute_inspect_multi_dex(options)
        end
      end
      
      def execute_inspect_multi_dex(options)
        if options[:directory] && options[:project]
          MultiDexInspector.analyze(options[:directory], options[:project])
        else
          puts 'Please give both directory (-d) and project (-p).'
        end
      end
    end
    
    private_class_method :new, :execute_inspect_multi_dex
  end
end