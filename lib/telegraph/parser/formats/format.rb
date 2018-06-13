module Telegraph
  module Parser
    module Formats
      class Format
        attr_reader :content

        def self.find(article_id, options={})
          article = Telegraph::Parser::Article.find(article_id)
          new(article, options)
        end

        def initialize(article, options = {})
          @article = article
          @options = options
          @content = ""
        end

        def process!
          raise 'Not implemented yet'
        end

        def save(destination)
          FileUtils.mkdir_p(destination)

          File.open("#{destination}/#{filename}", "w") do |f|
            f.write(@content)
          end
        end

        protected

        def filename
          raise 'Not implemented yet'
        end
      end
    end
  end
end