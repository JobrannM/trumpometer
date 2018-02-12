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

    daily_analysis_generator(watson_api.cnn_articles, watson_api.fox_articles, watson_api.nbc_articles)

  end

  private

  def select_most_pertinent_articles(medium_articles)
    sorted_medium_articles = medium_articles.sort_by { |article| article['total_reach']/article['tweet_timeframe']}
    sorted_medium_articles[0..4]
  end

  def daily_analysis_generator(cnn_articles, fox_articles, nbc_articles)

    daily_analysis = DailyAnalysis.new
    daily_analysis.day = Date.today - 1

    articles_generator(daily_analysis, cnn_articles)
    articles_generator(daily_analysis, fox_articles)
    articles_generator(daily_analysis, nbc_articles)

    trump_global_scoring(daily_analysis, cnn_articles)
    trump_global_scoring(daily_analysis, fox_articles)
    trump_global_scoring(daily_analysis, nbc_articles)

    daily_analysis.save!
  end

  def articles_generator(daily_analysis, medium_articles)
    medium_articles.each do |raw_article|
      article = Article.new
      article.daily_analysis = daily_analysis

      if raw_article["source"]["id"] == "fox-news"
        article.medium = Medium.find_by name: 'Fox News'
      elsif raw_article["source"]["id"] == "cnn"
        article.medium = Medium.find_by name: 'CNN'
      elsif raw_article["source"]["id"] == "nbc-news"
        article.medium = Medium.find_by name: 'NBC News'
      end

      article.title = raw_article["title"]
      article.author = raw_article["author"]
      article.url = raw_article["url"]
      article.url_image = raw_article["urlToImage"]
      article.description = raw_article["description"]
      article.publication_date = raw_article["publishedAt"]
      article.tweet_count = raw_article["tweet_count"]
      article.total_reach = raw_article["total_reach"]
      article.total_impression = raw_article["total_impression"]
      article.total_retweet = raw_article["total_retweet"]
      article.tweet_timeframe = raw_article["tweet_timeframe"]
      article.hashtag_cloud = raw_article["hashtag_cloud"]
      article.word_cloud = raw_article["word_cloud"]

      if raw_article['sentiments_data']["score"] < 0
        article.trump_sentiment = [raw_article['sentiments_data']["score"],"negative"]
      elsif raw_article['sentiments_data']["score"] > 0
        article.trump_sentiment = [raw_article['sentiments_data']["score"],"positive"]
      else
        article.trump_sentiment = [raw_article['sentiments_data']["score"],"neutral"]
      end

#HASH OR STRING ?????????
      article.trump_emotions =  {
        "sadness" => raw_article['sentiments_data']["sadness"],
        "joy" => raw_article['sentiments_data']["joy"],
        "fear" => raw_article['sentiments_data']["fear"],
        "disgust" => raw_article['sentiments_data']["disgust"],
        "anger" => raw_article['sentiments_data']["anger"]
      }
      article.save!
    end
  end

  def trump_global_scoring(daily_analysis, medium_articles)
    score_arr = []
    sadness_arr = []
    joy_arr = []
    fear_arr = []
    disgust_arr = []
    anger_arr = []

    medium_articles.each do |raw_article|
      score_arr << raw_article['sentiments_data']["score"]
      sadness_arr << raw_article['sentiments_data']["sadness"]
      joy_arr << raw_article['sentiments_data']["joy"]
      fear_arr << raw_article['sentiments_data']["fear"]
      disgust_arr << raw_article['sentiments_data']["disgust"]
      anger_arr << raw_article['sentiments_data']["anger"]
    end

    medium_trump_global_sentiment = score_arr.inject{ |sum, el| sum + el }.to_f / arr.size

    if medium_trump_global_sentiment < 0 && medium_articles[0]["source"]["id"] == "fox-news"
      daily_analysis.fox_trump_global_sentiment = [medium_trump_global_sentiment,"negative"]
    elsif medium_trump_global_sentiment > 0 && medium_articles[0]["source"]["id"] == "fox-news"
      daily_analysis.fox_trump_global_sentiment = [medium_trump_global_sentiment,"positive"]
    elsif medium_articles[0]["source"]["id"] == "fox-news"
      daily_analysis.fox_trump_global_sentiment = [medium_trump_global_sentiment,"neutral"]
    elsif medium_trump_global_sentiment < 0 && medium_articles[0]["source"]["id"] == "cnn"
       daily_analysis.cnn_trump_global_sentiment = [medium_trump_global_sentiment,"negative"]
    elsif medium_trump_global_sentiment > 0 && medium_articles[0]["source"]["id"] == "cnn"
      daily_analysis.cnn_trump_global_sentiment = [medium_trump_global_sentiment,"positive"]
    elsif medium_articles[0]["source"]["id"] == "cnn"
      daily_analysis.cnn_trump_global_sentiment = [medium_trump_global_sentiment,"neutral"]
    elsif medium_trump_global_sentiment < 0 && medium_articles[0]["source"]["id"] == "nbc-news"
      daily_analysis.nbc_trump_global_sentiment = [medium_trump_global_sentiment,"negative"]
    elsif medium_trump_global_sentiment > 0 && medium_articles[0]["source"]["id"] == "nbc-news"
      daily_analysis.nbc_trump_global_sentiment = [medium_trump_global_sentiment,"positive"]
    elsif medium_articles[0]["source"]["id"] == "nbc-news"
      daily_analysis.nbc_trump_global_sentiment = [medium_trump_global_sentiment,"neutral"]
    end

    medium_trump_global_emotions = {}
    medium_trump_global_sadness = sadness_arr.inject{ |sum, el| sum + el }.to_f / arr.size
    medium_trump_global_emotions["sadness"] << medium_trump_global_sadness
    medium_trump_global_joy = joy_arr.inject{ |sum, el| sum + el }.to_f / arr.size
    medium_trump_global_emotions["joy"] << medium_trump_global_joy
    medium_trump_global_fear = fear_arr.inject{ |sum, el| sum + el }.to_f / arr.size
    medium_trump_global_emotions["fear"] << medium_trump_global_fear
    medium_trump_global_anger = anger_arr.inject{ |sum, el| sum + el }.to_f / arr.size
    medium_trump_global_emotions["anger"] << medium_trump_global_anger

    if medium_articles[0]["source"]["id"] == "fox-news"
      daily_analysis.fox_trump_global_emotions = medium_trump_global_emotions
    elsif medium_articles[0]["source"]["id"] == "cnn"
      daily_analysis.cnn_trump_global_emotions = medium_trump_global_emotions
    elsif medium_articles[0]["source"]["id"] == "nbc-news"
      daily_analysis.nbc_trump_global_emotions = medium_trump_global_emotions
    end
  end
end
