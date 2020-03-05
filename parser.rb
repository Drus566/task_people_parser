# # Тестовое задание на парсинг
# ## Задание
# Необходимо написать парсер, который будет заходить на страницу Илона Маска в твиттере(twitter.com/elonmusk), 
# парсить 3 его последних поста(только текст) и для каждого поста вывести по 3 последних лайкнувших человека(ссылки на их аккаунты)
# ## Реализация
# Для реализации парсера необходимо использовать:
# - ruby 2.4
# - Faraday(gem)
# - Nokogiri(gem)
# ## Финальный вид
# Парсер должен запускаться так: ```ruby parser.rb``` и выдавать результат в консоли в удобно читаемом виде(на ваше усмотрение), например:

# ```
# Post 1:
# New Model S has 370 mile / 595 km range
# Liked by:
# - https://twitter.com/AliArslanoglu_
# - https://twitter.com/septicendoplier
# - https://twitter.com/og_djape

# Post 2:
# Motor Trend on Model S updates
# Liked by:
# - https://twitter.com/og_djape
# - https://twitter.com/sicxspliff
# - https://twitter.com/Cedric_hof

# Post 3:
# Model S drives from San Francisco to Los Angeles without recharging
# Liked by:
# - https://twitter.com/og_djape
# - https://twitter.com/septicendoplier
# - https://twitter.com/Cedric_hof
# ```
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

        # получаем данные с твита
        data = request('https://twitter.com' + links.first)
        # создаем документ твита
        tweet = Nokogiri::XML(data)
        # парсим сообщение твита
        text = parse_text(tweet)

        # # получаем данные о лайках
        # data = request('https://twitter.com' + links.first + 'likes', 'post')
        # # создаем документ твита
        # likes = Nokogiri::XML(data)
        # # парсим сообщение твита
        # liked = parse_likes(likes)


        links.each_with_index do |link, index| 
            data = request('https://twitter.com' + link)
            tweet = Nokogiri::XML(data)
            text = parse_text(tweet)
            puts "Post #{index + 1}:"
            puts text
            puts
        end
 

        # result = liked
        # выводим результаты
        # view(result)

    end

    def request(url, method = 'get')
        unless method.to_s.downcase == 'post'
            response = Faraday.get(url)
        else 
            # puts 'ggwp'
            # response = Faraday.get(url) do |req|
            #     req.headers['Host'] = 'api.twitter.com'
            #     req.headers['User-Agent'] = 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:73.0) Gecko/20100101 Firefox/73.0'
            #     req.headers['x-twitter-auth-type'] = 'OAuth2Session'
            #     req.headers['authorization'] = 'Bearer AAAAAAAAAAAAAAAAAAAAANRILgAAAAAAnNwIzUejRCOuH5E6I8xnZz4puTs%3D1Zv7ttfk8LF81IUq16cHjhLTvJu4FA33AGWWjCpTnA'
            #     req.headers['x-twitter-active-user'] = 'yes'
            #     req.headers['x-csrf-token'] = '3b84a52fbfe90c766f95509d947fb89f'
            #     req.headers['Cookie'] = '_ga=GA1.2.478329962.1567007602; dnt=1; kdt=11wbPox68X4SlpLRJTpLFL2if6wcHnh0Z2EIH4GY; remember_checked_on=1; csrf_same_site_set=1; csrf_same_site=1; ct0=3b84a52fbfe90c766f95509d947fb89f; _gid=GA1.2.2131060586.1583389103; gt=1235499168724127745; personalization_id="v1_rupKEoC+Jy55VFD2I/wJSQ=="; guest_id=v1%3A158340809001555208; _twitter_sess=BAh7CiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo%250ASGFzaHsABjoKQHVzZWR7ADoPY3JlYXRlZF9hdGwrCLlEfqpwAToMY3NyZl9p%250AZCIlZjJjYzM5YTIyMGNiNTA0MWIxZGMwZTM3NmIyZjM1Y2E6B2lkIiU3NjIx%250AMDlmYmQ5YmUxMjYxOGVhZDhmOGQ3NjU5YWY0ODoJdXNlcmwrCQCQ1zCGKIkM--dca3377b7f98e841cec314ae1dbb965649337e68; ads_prefs="HBESAAA="; twid=u%3D903297757074657280; auth_token=e168ed5a10eec9e3935a41804b19e47d0ece6155; rweb_optin=side_no_out'
            # end


            # url: 'http://sushi.com',
            # params: {param: '1'},
            # headers: {'Content-Type' => 'application/json'}

#             req.params['limit'] = 100
        #     req.headers['Content-Type'] = 'application/json'
        #     req.body = {query: 'salmon'}.to_json

            # Host: api.twitter.com
            # User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:73.0) Gecko/20100101 Firefox/73.0
            # Accept: */*
            # Accept-Language: en-US,en;q=0.5
            # Accept-Encoding: gzip, deflate, br
            # Referer: https://twitter.com/Tesla/status/1235278941494980608
            # authorization: Bearer AAAAAAAAAAAAAAAAAAAAANRILgAAAAAAnNwIzUejRCOuH5E6I8xnZz4puTs%3D1Zv7ttfk8LF81IUq16cHjhLTvJu4FA33AGWWjCpTnA
            # x-twitter-auth-type: OAuth2Session
            # x-twitter-client-language: ru
            # x-twitter-active-user: yes
            # content-type: application/x-www-form-urlencoded
            # x-csrf-token: 3b84a52fbfe90c766f95509d947fb89f
            # Origin: https://twitter.com
            # Content-Length: 974
            # Connection: keep-alive
            # Cookie: _ga=GA1.2.478329962.1567007602; dnt=1; kdt=11wbPox68X4SlpLRJTpLFL2if6wcHnh0Z2EIH4GY; remember_checked_on=1; csrf_same_site_set=1; csrf_same_site=1; ct0=3b84a52fbfe90c766f95509d947fb89f; _gid=GA1.2.2131060586.1583389103; gt=1235499168724127745; personalization_id="v1_rupKEoC+Jy55VFD2I/wJSQ=="; guest_id=v1%3A158340809001555208; _twitter_sess=BAh7CiIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZsYXNo%250ASGFzaHsABjoKQHVzZWR7ADoPY3JlYXRlZF9hdGwrCLlEfqpwAToMY3NyZl9p%250AZCIlZjJjYzM5YTIyMGNiNTA0MWIxZGMwZTM3NmIyZjM1Y2E6B2lkIiU3NjIx%250AMDlmYmQ5YmUxMjYxOGVhZDhmOGQ3NjU5YWY0ODoJdXNlcmwrCQCQ1zCGKIkM--dca3377b7f98e841cec314ae1dbb965649337e68; ads_prefs="HBESAAA="; twid=u%3D903297757074657280; auth_token=e168ed5a10eec9e3935a41804b19e47d0ece6155; rweb_optin=side_no_out
            # TE: Trailers
        end

        unless response.status == 200 
            puts "#{response.headers}"
        end
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

    # парсинг лайкнувших
    def parse_likes(document)
        document
    end

    # результаты
    def view(data)
        $stdout = File.open('text.txt', 'w')
        puts data 
        # puts data.inspect
        # puts data.inspect
    end

    # def write_file(data)
    #     if File.exist? 'text.txt'
    #         File.foreach( 'text.txt', 'w' ) do |line|
    #             puts data
    #             puts 'ggwp'
    #         end
    #     end
    # end
end

parser = TwitterParser.new
parser.start