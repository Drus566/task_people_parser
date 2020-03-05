require 'nokogiri'
require 'faraday'

class TwitterParser 

    def start
        # получаем данные
        data = request('https://twitter.com/elonmusk/tweets')
        # создаем документ главной страницы
        document = Nokogiri::XML(data)
        # парсим ссылки на 3 последних твита
        links = parse_links(document)

        # Проходим по ссылка и отображаем сообщение твитов
        links.each_with_index do |link, index| 
            data = request('https://twitter.com' + link)
            tweet = Nokogiri::XML(data)
            text = parse_text(tweet)
            puts "Post #{index + 1}:"
            puts text
            puts
        end
    end

    def request(url)
        response = Faraday.get(url)
        puts "Error #{response.status}" unless response.status == 200 
        
        response.body
    end

    # парсинг три последних твита
    def parse_links(document)
        links = []
        document.css('a[class="tweet-timestamp js-permalink js-nav js-tooltip"]').first(3).each { |a| links << a.attr('href') }
        links        
    end

    # парсинг текста 
    def parse_text(document)
        document.css('div.js-tweet-text-container p').children[0].text
    end
end

parser = TwitterParser.new
parser.start