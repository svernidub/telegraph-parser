require 'open-uri'

module Telegraph
  module Parser
    class Fetcher
      HOST = 'telegra.ph'.freeze

      def fetch(article_id)
        response = Net::HTTP.get_response(article_uri(article_id))
        handle_response(response)
      rescue EOFError
        raise Telegraph::Parser::ArticleNotFound
      end

      def fetch_image(src, prefix)
        src = src.start_with?('http') ? src : "https://#{HOST}#{src}"
        { image_id(src, prefix) => open(src).read }
      end

      def image_id(src, prefix)
        "#{prefix}/#{File.basename(URI.parse(src).path)}"
      end

      private

      def article_uri(article_id)
        URI("https://#{HOST}/#{article_id}")
      end

      def handle_response(response)
        case response.code
        when '404'
          raise Telegraph::Parser::ArticleNotFound
        when '200'
          response.body
        end
      end
    end
  end
end
