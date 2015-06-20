module Gradleman
  class StringUtil
    class << self
      def colorize(text, color)
        case color.intern
        when :red
          apply_color_code_to_text('31', text)
        when :green
          apply_color_code_to_text('32', text)
        when :yellow
          apply_color_code_to_text('33', text)
        else
          text
        end
      end
      
      def apply_color_code_to_text(color_code, text)
        "\e[%color_code%m%text%\e[0m".gsub('%color_code%', color_code).gsub('%text%', text)
      end
    end
    
    private_class_method :apply_color_code_to_text
  end
end