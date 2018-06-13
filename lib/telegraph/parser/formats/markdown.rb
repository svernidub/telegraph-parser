require 'html2markdown'

module Telegraph
  module Parser
    module Formats
      class Markdown < Html
        def process!
          build_content
          convert_to_md
        end

        protected

        def convert_to_md
          @content = HTMLPage.new(contents: @content).markdown
        end

        def filename
          "#{@article.title}.md"
        end

      end
    end
  end
end