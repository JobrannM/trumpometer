

require 'capybara/poltergeist'

def init_capybara
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false)
  end
  Capybara.default_driver = :poltergeist
end

def scrapper_capybara(medium_articles)
  browser = Capybara.current_session

  medium_articles.each do |article|
    url_article = article["url"]
    url = "https://socialbearing.com/search/general/" + url_article
    browser.visit url

    n1_tweets_count = browser.find('h2.tweet-count').text
    loop do
      n_tweets_count = n1_tweets_count
      browser.find('a.load_more').click
      sleep(10)
      n1_tweets_count = browser.find('h2.tweet-count').text
      break if n1_tweets_count == n_tweets_count
    end

    article["tweet_count"] = n1_tweets_count.to_i
    article["tweet_timeframe"] = browser.find('h2.tweet-timeframe').text
    article["total_reach"] = browser.find('span.total-reach').text
    article["total_impression"] = browser.find('span.total-impressions').text
    article["total_retweet"] = browser.find('h2.total-retweet').text

    hashtag_cloud = []
    browser.find_by_id('hash_cloud').all('span').each do |hash_tag_span|
      pair = []
      pair << hash_tag_span.text
      pair << hash_tag_span['class'].slice(1).to_i
      hashtag_cloud << pair
    end
    article["hashtag_cloud"] = hashtag_cloud

    word_cloud = []
    browser.find_by_id('word_cloud').all('span').each do |word_span|
      pair = []
      pair << word_span.text
      pair << word_span['class'].slice(1).to_i
    end
    article["word_cloud"] = word_cloud
  end
end

def quit_capybara
  browser.reset_session!
  browser.driver.quit
  browser = nil
end

init_capybara
scrapper_capybara(fox_articles)
scrapper_capybara(cnn_articles)
scrapper_capybara(nbc_articles)


