module Telegraph
  module Parser
    module Formats
      class Html < Format
        def process!
          build_content
        end

        def build_content
          @content = <<-HTML.strip
            <html>
              <head>
                <meta charset="UTF-8">
                <title>#{@article.title}</title>
              </head>

              <body>
                <h1>
                  #{@article.title}
                  <small>#{@article.author}</small>
                </h1>

                <div>
                  #{@article.content}
                </div>
              </body>
            </html>
          HTML
        end
  
        def save(destination)
          super
  
          @article.images.each do |path, image|
            ensure_path_exists(destination, path)

            File.open("#{destination}#{path}", 'wb') do |f|
              f.write(image)
            end
          end

          true
        end

        protected
  
        def filename
          "#{@article.title}.html"
        end

        def ensure_path_exists(destination, path)
          dir_seg = File.dirname("#{destination}#{path}")
          FileUtils.mkdir_p(dir_seg)
        end
      end
    end
  end
end