module Gradleman
  class MultiDexInspector
    class << self
      def list_dependency_hierarchy(directory, project)
        cmd = "cd #{directory} && gradle :#{project}:dependencies"
        begin
          output = `#{cmd}`
        rescue Exception => e
          puts e.message
        end
        output
      end
      
      def parse(output)
        regex_dep = /(((\w+\.)*+\w+:[\w\-\.]+):(.*+))|(:(.*?):)/
        regex_cfg = /^([^\s]*)?\s-\s.*/
        set = {}
        cfg = nil
        output.lines do |l|
          if regex_cfg.match(l)
            cfg = $~[1]
            set[cfg] = []
          elsif regex_dep.match(l) && !cfg.nil?
            if $~[6].nil?
              name = $~[2]
              version = $~[4]
            else
              name = $~[6]
              version = nil
            end
            collision = false
            set[cfg].each do |x|
              if x[:name] == name
                collision = true
                x[:versions].push(version)
                break
              end
            end
            unless collision
              set[cfg].push({:name => name, :versions => [version]})
            end
          end
        end
        return set
      end
      
      def inspect(set)
        results = {}
        set.each do |k, v|
          results[k] = []
          v.each do |x|
            if x[:versions].size > 1
              results[k].push(x)
            end
          end
        end
        return results
      end
      
      def report(results)
        results.each do |k, v|
          puts k
          if v.size > 0
            puts StringUtil.colorize('Collision found:', :red)
            v.each do |x|
              puts StringUtil.colorize(x[:name], :yellow) + " => #{x[:versions]}"
            end
          else
            puts StringUtil.colorize('No collision', :green)
          end
          puts "\n" + '=' * 70 + "\n\n"
        end
      end
      
      def analyze(path, project)
        report(inspect(parse(list_dependency_hierarchy(path, project))))
      end
    end
    
    private_class_method :list_dependency_hierarchy, :parse, :inspect, :report
  end
end