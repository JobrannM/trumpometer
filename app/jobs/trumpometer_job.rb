class TrumpometerJob < ApplicationJob
  queue_as :default

  def perform
    news_api = NewsApiService.new
    news_api.perform

    social_scrapper = SocialScrapperService.new(news_api.cnn_articles, news_api.fox_articles, news_api.nbc_articles)
    social_scrapper.perform

    curated_cnn_articles = select_most_pertinent_articles(social_scrapper.cnn_articles)
    curated_fox_articles = select_most_pertinent_articles(social_scrapper.fox_articles)
    curated_nbc_articles = select_most_pertinent_articles(social_scrapper.nbc_articles)

    watson_api = WatsonApiService.new(curated_cnn_articles, curated_fox_articles, curated_nbc_articles)
    watson_api.perform

    articles_generator(watson_api.cnn_articles)
    articles_generator(watson_api.fox_articles)
    articles_generator(watson_api.nbc_articles)

  end

  private

  def select_most_pertinent_articles(medium_articles)
    sorted_medium_articles = medium_articles.sort_by { |article| article['total_reach']/article['tweet_timeframe']}
    sorted_medium_articles[0..4]
  end

  def articles_generator(medium_articles)

# ADD THE ARTICLES DB SAVE HERE

  end
end
