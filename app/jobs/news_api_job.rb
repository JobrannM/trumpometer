require 'open-uri'
require 'json'

class NewsApiJob < ApplicationJob
  queue_as :default

  def perform

    date = Date.today.strftime("%F")

    url = 'https://newsapi.org/v2/everything?'\
          'sources=fox-news,nbc-news,cnn&'\
          'q=+trump&'\
          'language=en&'\
          "from=#{date}&to=#{date}"\
          'page=1&'\
          'pageSize=100&'\
          'sortBy=relevancy&'\
          "apiKey=#{ENV['GOOGLE_NEWS_KEY']}"

    req = open(url).read
    response_body = JSON.parse(req)
    articles = response_body["articles"]

    #initialize arrays to store results
    fox_articles = []
    cnn_articles = []
    nbc_articles = []

    i = 0 #total article number
    f = 0 # total fox news articles
    c = 0 # total cnn articles
    n = 0 #total nbc articles
    articles.each do |article|
      if article["title"].include?("Trump")
        i += 1
        if article["source"]["name"] == "Fox News"
          f +=1
          fox_articles << article
        elsif article["source"]["name"] == "CNN"
          c += 1
          cnn_articles << article
        else
          n += 1
          nbc_articles << article
        end
      end
    end

    # p "Found #{i} articles with Trump in the title."
    # p "##########################################################################"

    # p "#{f} articles are from Fox News:"
    # fox_articles.each_with_index do |fox_article, index|
    #   p "#{index + 1}) #{fox_article["title"]}"
    # end
    # p "##########################################################################"
    # p "#{c} articles are from CNN:"
    # cnn_articles.each_with_index do |cnn_article, index|
    #   p "#{index + 1}) #{cnn_article["title"]}"
    # end
    # p "##########################################################################"
    # p "#{n} articles are from NBC:"
    # nbc_articles.each_with_index do |nbc_article, index|
    #   p "#{index + 1}) #{nbc_article["title"]}"
    # end
  end
end
